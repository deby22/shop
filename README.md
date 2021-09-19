# Shop

Build project: `docker-compose build`
Start project: `docker-compose up -d`
Run migration: `docker exec -it shop mix ecto.setup`

## Description

Project allow to submit Cart
Cart require at least one product.
Cart contain list of products
There is allowed max 3 products with the same name
If Cart contains 5 products total value of cart is reduced by 1%
If Cart contains 10 products total value of cart is reduced by 2%
If Cart contains 20 products total value of cart is reduced by 5%
If there is used `coupon` total value of cart is reduced by 5%.


TODO:
    Schema
        Validation Coupon
        Validation Cart
    Context
        Multi.transaction - use coupon