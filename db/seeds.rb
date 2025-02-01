# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

unless User.find_by(email: 'admin@example.com')
  User.create!(
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password'
  )
end

# Create Product Type
[ "bicycle" ].each do |product_type|
  ProductType.find_or_create_by!(name: product_type)
end

bicycle_product_type = ProductType.find_by(name: "bicycle")

# Create Products
[
  {
    name: "Specialized Roubaix SL8 Road Bike",
    price: 279999,
    product_type: bicycle_product_type,
    url_media_files_attributes: [{url: "https://www.bikeride.com/images/bike/Specialized-Roubaix-SL8-1024x630.jpg"}]
  },
  {
    name: "Contend 3 Road Bike",
    price: 84999,
    product_type: bicycle_product_type,
    url_media_files_attributes: [{url: "https://images2.giant-bicycles.com/b_white%2Cc_pad%2Ch_850%2Cq_80/odaxudcxgex1h4xyrdca/MY25Contend3_ColorAColdIron.jpg"}]
  },
  {
    name: "Stumpjumper Comp Mountain Bike",
    price: 349999,
    product_type: bicycle_product_type,
    url_media_files_attributes: [{url: "https://assets.specialized.com/i/specialized/93321-51_SJ-COMP-WHTMTN-BLK_HERO?$scom-pdp-gallery-image$&fmt=webp"}]
  }
].each do |product_attributes|
  next if Product.find_by(name: product_attributes[:name])

  Product.create!(product_attributes)
end

# Create Accessory Type and Accessory
[
  {
    name: "Frame Type",
    product_type_id: bicycle_product_type.id,
    accessories_attributes: [
      {
        name: "Full-suspension",
        price: 13000,
        url_media_files_attributes: [{url: "https://www.risenbicycle.com/photo/risenbicycle/editor/20161026213424_39700.jpg"}]
      },
      {
        name: "Diamond",
        price: 10000,
        url_media_files_attributes: [{url: "https://i.pinimg.com/originals/93/47/f8/9347f894041e55fa333ea2dc53446710.jpg"}]
      },
      {
        name: "Step-through",
        price: 12000,
        url_media_files_attributes: [{url: "https://www.lightweightbikeframe.com/photo/pl18368849-electric_step_through_bike_frame_aluminum_alloy_bicycle_step_through_frame.jpg"}]
      }
    ]
  },
  {
    name: "Frame finish",
    product_type_id: bicycle_product_type.id,
    accessories_attributes: [
      {
        name: "Matte",
        price: 3000
      },
      {
        name: "Shiny",
        price: 5000
      }
    ]
  },
  {
    name: "Wheels",
    product_type_id: bicycle_product_type.id,
    accessories_attributes: [
      {
        name: "Road wheels",
        price: 8000,
        url_media_files_attributes: [{url: "https://sscycleworks.com/images/components-sale/wheels/Sta-Tru-27-inch-wheel-set-01.jpg"}]
      },
      {
        name: "Mountain wheels",
        price: 10000,
        url_media_files_attributes: [{url: "https://bikingtribe.com/wp-content/uploads/2018/01/vuelta-xrp-pro-26-inches-mountain-bike-wheel-set.jpg"}]
      },
      {
        name: "Fat bike wheels",
        price: 12000,
        url_media_files_attributes: [{url: "https://fat-bike.com/wp-content/uploads/2016/03/dirt-components-thumper-82mm-fat-bike-wheel-set-647.jpg"}]
      }
    ]
  },
  {
    name: "Rim Color",
    product_type_id: bicycle_product_type.id,
    accessories_attributes: [
      {
        name: "Red",
        price: 2000
      },
      {
        name: "Black",
        price: 2000
      },
      {
        name: "Blue",
        price: 2000
      }
    ]
  },
  {
    name: "Chain",
    product_type_id: bicycle_product_type.id,
    accessories_attributes: [
      {
        name: "Single-speed chain",
        price: 4300,
        url_media_files_attributes: [{url: "https://i.ebayimg.com/images/g/DRoAAOSwk5FUydcC/s-l400.jpg"}]
      },
      {
        name: "8-speed chain",
        price: 7500,
        url_media_files_attributes: [{url: "https://ae01.alicdn.com/kf/HTB1B_5BgQfb_uJjSsrbq6z6bVXa8/Original-X8PL-8-Speed-KMC-Chain-for-Trekking-116-Links-Gold-Coated-Mountain-Bike-8S-MTB.jpg"}]
      }
    ]
  }
].each do |attributes|
  next if AccessoryType.find_by(name: attributes[:name])

  AccessoryType.create!(attributes)
end

# Create ComplementaryAccessoryPrice and  ComplementaryAccessoryConstraint
first_acceesories = AccessoryType.first.accessories
second_acceesories = AccessoryType.second.accessories

ComplementaryAccessoryPrice.find_or_create_by!(
  accessory_id: first_acceesories.first.id,
  complementary_accessory_id: second_acceesories.first.id,
  price: 1000
)

ComplementaryAccessoryConstraint.find_or_create_by!(
  accessory_id: first_acceesories.second.id,
  complementary_accessory_id: second_acceesories.second.id
)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
