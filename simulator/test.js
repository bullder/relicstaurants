const { chromium } = require('playwright');
const delay = (ms) => new Promise(res => setTimeout(res, ms));

(async () => {
  const browser = await chromium.launch({ headless: false }); // set to true to run headless
  const context = await browser.newContext();
  const page = await context.newPage();
  // const url = 'http://localhost:3000/';
  const url = 'https://relicstaurants.garifull.in/';
  const address = '432 Wiggly Rd, Mountain View, 94043';

  while (true) {
    await page.goto(url);
    await delay(1000);

    await page.fill('input[placeholder="Enter your address"]', address);
    await delay(1000);

    await page.click('.ant-btn-primary');
    await delay(2000);

    const restaurants = await page.$$('div.sc-kgflAQ.gxKQJf');
    if (!restaurants.length) continue;

    await restaurants[Math.floor(Math.random() * restaurants.length)].click();
    await delay(2000);

    if (Math.random() < 0.4) {
      await page.click('.ant-badge');
      await delay(3000);

      await page.click('#pay');
      await delay(2000);

      page.once('dialog', async dialog => await dialog.accept());
      await delay(2000);
    } else {
      const menuItems = await page.$$('#menuItem');
      const selected = menuItems.sort(() => 0.5 - Math.random()).slice(0, 3);

      for (const item of selected) {
        await item.hover();
        await item.click();
        await delay(1000);
      }

      await page.click('.ant-badge');
      await delay(3000);

      await page.click('#pay');
      await delay(2000);

      const cardNumber = Array.from({ length: Math.random() < 0.5 ? 16 : 15 }, () => Math.floor(Math.random() * 10)).join('');
      await page.fill('#cardNumber', cardNumber);
      await delay(1000);

      const csv = Array.from({ length: 3 }, () => Math.floor(Math.random() * 10)).join('');
      await page.fill('#csv', csv);
      await delay(2000);

      await page.click('#submit');
      await delay(2000);
    }
  }
})();
