
import { checkUserIsRegisterd } from "$lib/js/utils.js";

export function validateRegisterPassword(password) {
  if (password.length < 8) {
    return { result: false, errorMsg: "Password must be at least 8 characters" };
  } else if (password.length > 30) {
    return { result: false, errorMsg: "Password must be less than 30 characters" };
  } else if (password.includes(" ")) {
    return { result: false, errorMsg: "Password cannot contain spaces." };
  } else if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$/.test(password)) {
    return { result: false, errorMsg: "Min. 8 characters, 1 uppercase, 1 lowercase, 1 number. ONLY the following special characters are allowed: @$!%*?&." };
  }
  return { result: true, errorMsg: "" };
}

export async function validateRegisterName(name) {
  if (name.length < 1 || name.length > 30) {
    return { result: false, errorMsg: "This name must be between 1 and 30 characters." };
  } else if (name.includes(" ")) {
    return { result: false, errorMsg: "This name cannot contain spaces." };
  } else if (!/^[a-zA-Z0-9_]+$/.test(name)) {
    return { result: false, errorMsg: "This name can only contain underscore, letters and numbers." };
  }
  return { result: true, errorMsg: "" };
}

export async function validateRegisterUserName(userName) {
  const userIsExisted = await checkUserIsRegisterd(userName);
  if (userName.length < 3 || userName.length > 20) {
    return { result: false, errorMsg: "Username must be between 3 and 20 characters." };
  } else if (userName.includes(" ")) {
    return { result: false, errorMsg: "Username cannot contain spaces." };
  } else if (!/^[a-zA-Z0-9_]+$/.test(userName)) {
    return { result: false, errorMsg: "Username can only contain underscore, letters and numbers." };
  } else if (userIsExisted.exists) {
    return { result: false, errorMsg: "Username already exists." };
  }
  return { result: true, errorMsg: "" };
}

export async function validateUpdateUserName(userName) {
  const userIsExisted = await checkUserIsRegisterd(userName);
  if (userName.length < 3 || userName.length > 20) {
    return { result: false, errorMsg: "Username must be between 3 and 20 characters." };
  } else if (userName.includes(" ")) {
    return { result: false, errorMsg: "Username cannot contain spaces." };
  } else if (!/^[a-zA-Z0-9_]+$/.test(userName)) {
    return { result: false, errorMsg: "Username can only contain underscore, letters and numbers." };
  } else if (userIsExisted.exists) {
    return { result: false, errorMsg: "Username already exists." };
  }
  return { result: true, errorMsg: "" };
}

export function validateRegisterEmail(email) {
  if (!email) {
    return { result: false, errorMsg: "Email cannot be empty." };
  } else if (email.length > 64) {
    return { result: false, errorMsg: "Email must be less than 50 characters." };
  } else if (!/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(email)) {
    return { result: false, errorMsg: "Invalid email format." };
  }
  return { result: true, errorMsg: "" };
}

export function validateRegisterDate(date) {
  if (!date) {
    return { result: false, errorMsg: "Date cannot be empty." };
  } else if (date.length > 20) {
    return { result: false, errorMsg: "Date must be less than 20 characters." };
  }
  return { result: true, errorMsg: "" };
}

export function validateConfirmPassword(getPassword) {
  return function (value) {
    const password = getPassword();
    if (!value) return { result: false, errorMsg: "Password cannot be empty" };
    if (value !== password) {
      return { result: false, errorMsg: "Password does not match" };
    }
    return { result: true, errorMsg: "" };
  }
}