import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '15s', target: 10 },
    { duration: '30s', target: 20 },
    { duration: '15s', target: 0 },
  ],
};

const BASE_DOMAIN = 'https://new.garifull.in';
// const BASE_DOMAIN = 'http://localhost:3000';
const BASE_URL = BASE_DOMAIN + '/api/restaurant';

export default function () {
  // Test the /api/restaurant endpoint
  const res1 = http.get(BASE_URL);
  check(res1, {
    'GET /api/restaurant status is 200': (r) => r.status === 200,
  });

  const restaurants = res1.json();
  if (restaurants.length > 0) {
    const randomRestaurant = restaurants[Math.floor(Math.random() * restaurants.length)];
    const randomId = randomRestaurant.id;

    const res2 = http.get(`${BASE_URL}/${randomId}`);
    check(res2, {
      'GET /api/restaurant/:id status is 200': (r) => r.status === 200,
    });
  }

  sleep(1);
}