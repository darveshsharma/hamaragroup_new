# Clear existing data if needed (optional)
ConsultationRequest.destroy_all
Property.destroy_all


User.destroy_all
AdminUser.destroy_all


# === 🗂️ Create ActiveAdmin admin user ===
AdminUser.find_or_create_by!(email: "admin@hamaragroup.in") do |admin|
 admin.password = "password"
 admin.password_confirmation = "password"
end


# === 👤 Create application User model admin ===
admin_user = User.find_or_create_by!(email: "admin_user@hamaragroup.in") do |user|
 user.password = "password"
 user.role = "admin"
 user.member = true
end


# === 👤 Create member user ===
member_user = User.find_or_create_by!(email: "member@hamaragroup.in") do |user|
 user.password = "password"
 user.role = "owner"   # role set to owner as per your enum
 user.member = true    # set member to true
end


# === 🏠 Create dummy properties ===
5.times do |i|
 Property.find_or_create_by!(title: "Sample Property #{i+1}") do |property|
   property.description = "This is a dummy description for property #{i+1}."
   property.price = (10 + i) * 10_00_000
   property.location = "Delhi NCR"
   property.property_type = "Residential"
   property.user = admin_user
 end
end


# === 💬 Create dummy consultation requests ===
3.times do |i|
 ConsultationRequest.find_or_create_by!(summary: "Need consultation for property purchase support #{i+1}.") do |request|
   request.full_name = "User #{i+1}"
   request.phone_number = "98765432#{i}"
   request.service_type = "Property Purchase Support"
   request.status = "pending"
   request.user = member_user
   request.property = Property.first
   request.supporting_document = nil
 end
end


puts "✅ Seeded dummy AdminUser, Users, properties, and consultation requests safely."


