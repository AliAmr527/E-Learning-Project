import axios from "axios"
export const checkUser = async(userId)=>{
    return await axios.get(`http://localhost:5001/auth/checkUser/${userId}`)
}