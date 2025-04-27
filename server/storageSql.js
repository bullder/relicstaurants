const { Pool } = require('pg');

var PostgresStorage = function(config) {
  const pool = new Pool(config);

  this.getAll = async function() {
    try {
      const result = await pool.query('SELECT * FROM restaurants');
      return Array.isArray(result.rows) ? result.rows : [];
    } catch (error) {
      console.error('Error fetching restaurants:', error);
      return [];
    }
  };

  this.add = async function(item) {
    const existing = await pool.query('SELECT id FROM restaurants WHERE id = $1', [item.id]);
    if (existing.rows.length > 0) {
      throw new Error(`Duplicate key value violates unique constraint: id '${item.id}' already exists.`);
    }

    const query = `
      INSERT INTO restaurants (id, name, cuisine, opens, closes, days, price, rating, location, description)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
    `;
    const values = [
      item.id,
      item.name,
      item.cuisine,
      item.opens,
      item.closes,
      item.days,
      item.price,
      item.rating,
      item.location,
      item.description,
    ];
    await pool.query(query, values);
  };

  this.getById = async function(id) {
    const restaurantResult = await pool.query('SELECT * FROM restaurants WHERE id = $1', [id]);
    if (!restaurantResult.rows[0]) {
      return null;
    }
    const restaurant = restaurantResult.rows[0];
    const menuItemsResult = await pool.query('SELECT * FROM menuitems WHERE cuisine = $1', [restaurant.cuisine]);
    restaurant.menuItems = menuItemsResult.rows;
    return restaurant;
  };

  this.deleteById = async function(id) {
    const result = await pool.query('DELETE FROM restaurants WHERE id = $1', [id]);
    return result.rowCount > 0;
  };
};

exports.Postgres = PostgresStorage;