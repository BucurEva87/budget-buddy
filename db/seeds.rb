# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Upload the default images for User and Group as blobs in ActiveStorage
{
  user_default: Rails.root.join('app', 'assets', 'images', 'user_default.png'),
  group_default: Rails.root.join('app', 'assets', 'images', 'group_default.png')
}.each do |key, path|
  blob = ActiveStorage::Blob.create_before_direct_upload!(
    filename: File.basename(path),
    byte_size: File.size(path),
    content_type: Mime::Type.lookup_by_extension(File.extname(path)[1..-1]).to_s,
    checksum: Digest::SHA256.file(path).hexdigest,
    key: key
  )

  blob.upload(File.open(path))
  blob.analyze
end

# Create two default users
users = User.create!([
  {
    name: 'Bucur Eva-Lavinia',
    email: 'bucur.eva87@gmail.com',
    password: 's0m3t3st',
    confirmed_at: Time.now
  },
  {
    name: 'Mobutu Seseseko',
    email: 'mobutu.seseseko@gmail.com',
    password: '4n0th3rt3st',
    confirmed_at: Time.now
  }
])

# Create some default Groups
groups = Group.create!([
  { name: 'Zara', author: User.last },
  { name: 'Microsoft', author: User.first },
  { name: 'McDonnalds', author: User.first }
])

# Create five entries
entries = Entry.create!([
  {
    name: 'Black evening dress',
    amount: 129.98,
    author: User.first,
    groups: [Group.first]
  },
  {
    name: 'MS Office 2023',
    amount: 154.22,
    author: User.first,
    groups: [Group.find(2)]
  },
  {
    name: 'Subscription',
    amount: 24,
    author: User.last,
    groups: [Group.first, Group.find(2)]
  },
  {
    name: 'Big Mac',
    amount: 2.99,
    author: User.first,
    groups: [Group.last]
  },
  {
    name: 'Happy Meal',
    amount: 3.00,
    author: User.first,
    groups: [Group.last]
  }
])
