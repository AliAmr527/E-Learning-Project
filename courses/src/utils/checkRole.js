export const checkRole = (role) =>{
    return (req,res,next) =>{
        if(req.body.role === role){
            next()
        }else{
            console.log(req.body.role)
            res.status(401).send({message:"Unauthorized"})
        }
    }
}