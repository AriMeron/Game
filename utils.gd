extends Node

func normalizeVelocity(velocity : Vector3):
	var scaleFactor = (sqrt(velocity.x * velocity.x + 2 * velocity.z * velocity.z)) / velocity.length_squared()
	return velocity * scaleFactor;
