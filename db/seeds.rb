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

