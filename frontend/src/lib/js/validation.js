
export function validateRegisterPassword(password) {
    if (password.length < 8) {
      return { result: false, errorMsg: "Password must be at least 8 characters" };
    } else if (password.includes(" ")) {
      return { result: false, errorMsg: "Password cannot contain spaces." };
    } else if (!/[!@#$%^&*]/.test(password)) {
      return { result: false, errorMsg: "Password must contain at least one special character." };
    } else if (!/[0-9]/.test(password)) {
      return { result: false, errorMsg: "Password must contain at least one number." };
    } else if (!/[A-Za-z]/.test(password)) {
      return { result: false, errorMsg: "Password must contain at least one letter." };
    }
    return { result: true, errorMsg: "" };
  }
  
export function validateRegisterUserName(userName) {
    if (userName.length < 3 || userName.length > 20) {
      return { result: false, errorMsg: "Username must be between 3 and 20 characters." };
    } else if (userName.includes(" ")) {
      return { result: false, errorMsg: "Username cannot contain spaces." };
    } else if (!/^[a-zA-Z0-9_]+$/.test(userName)) {
      return { result: false, errorMsg: "Username can only contain underscore, letters and numbers." };
    } else if (!usernameUnique((userName)=>{return true;})) {
      return { result: false, errorMsg: "Username already exists." };
    }
    return { result: true, errorMsg: "" };
  }

  export function validateConfirmPassword(passwordObj) {
    console.log(passwordObj);
    return function(value) {
      if (!value) return { result: false, errorMsg: "Password cannot be empty" };
      if (value !== passwordObj.password) {
        return { result: false, errorMsg: "Password does not match" };
      }
      return { result: true, errorMsg: "" };
    }
  }