import User from "../../../../db/model/user.model.js"

export const register = async (req, res) => {
	const { name, email, password, affiliation, yearsOfExperience, bio, role } = req.body
	try {
		const isExist = await User.findOne({ email })
		if (isExist) return res.status(400).send({ message: "User already exist!" })
		const user = await User.create({ name, email, password, affiliation, yearsOfExperience, bio, role })
		const output = {
			id: user._id,
			role: user.role,
		}
		res.status(200).json( output )
	} catch (error) {
		res.status(400).json({ message: error.message })
	}
}

export const login = async (req, res) => {
	const { email, password } = req.body
	try {
		const user = await User.findOne({ email })
		if (!user) {
			return res.status(400).send({ message: "User not found!" })
		}
		if (user.password !== password) {
			return res.status(400).send({ message: "Incorrect password!" })
		}
		const output = {
			id: user._id.toString(),
			role: user.role,
			name: user.name,
		}
		res.status(200).json( output )
	} catch (error) {
		res.status(400).json({ message: error.message })
	}
}

export const checkUser = async (req, res) => {
	const user = await User.findById(req.params.id)
	if (!user) {
		return res.status(200).send("doesn't exist")
	}
	return res.status(200).json("exists")
}
