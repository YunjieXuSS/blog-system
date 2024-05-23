
export function validateRegisterPassword(password) {
    if (password.length < 8) {
      return { result: false, errorMsg: "Password must be at least 8 characters" };
    } else if (password.includes(" ")) {
      return { result: false, errorMsg: "Password cannot contain spaces." };
    } else if (!/[!@#$%^&*_-]/.test(password)) {
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

  
  function usernameUnique(userName) {
 //not done yet

  return true;
}

  export function validateRegisterEmail(email) {
    if (!email) {
      return { result: false, errorMsg: "Email cannot be empty." };
    } else if (email.length > 50) {
      return { result: false, errorMsg: "Email must be less than 50 characters." };
    } else if (!/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(email)) {
      return { result: false, errorMsg: "Invalid email format." };
    } 
    return { result: true, errorMsg: "" };
  }


  // export function validateConfirmPassword(passwordObj) {
  //   console.log("passwordObj",passwordObj);
  //   return function(value) {
  //     if (!value) return { result: false, errorMsg: "Password cannot be empty" };
  //     if (value !== passwordObj.password) {
  //       return { result: false, errorMsg: "Password does not match" };
  //     }
  //     return { result: true, errorMsg: "" };
  //   }
  // }


  export function validateRegisterDate(date) {
    if (!date) {
      return { result: false, errorMsg: "Date cannot be empty." };
    } else if (date.length > 10) {
      return { result: false, errorMsg: "Date must be less than 10 characters." };
    } else if (!/^\d{4}$[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])/.test(email)) {
      return { result: false, errorMsg: "Invalid email format." };
    } 
    return { result: true, errorMsg: "" };
  }

  export function validateConfirmPassword(getPassword) {
    
    return function(value) {
      const password = getPassword();
      console.log("password",password);
      if (!value) return { result: false, errorMsg: "Password cannot be empty" };
      if (value !== password) {
        return { result: false, errorMsg: "Password does not match" };
      }
      return { result: true, errorMsg: "" };
    }
  }