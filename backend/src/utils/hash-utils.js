import bcrypt from "bcrypt";
export async function createPasswordHashSalt(password) {
  //create salt and hash
  const salt = bcrypt.genSaltSync(12);
  const hashedPassword = await bcrypt.hash(password, salt);
  return hashedPassword;
}
