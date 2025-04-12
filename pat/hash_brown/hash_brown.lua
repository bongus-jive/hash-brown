local Hash_Brown = "hash_brown"

function init()
  self.scale = animator.partProperty(Hash_Brown, "scale")
  self.offset = animator.partProperty(Hash_Brown, "offset")
  self.idleAngle = config.getParameter("idleAngle", -90) * (math.pi / 180)
  self.pitchNRand = config.getParameter("pitchNRand")
end

function update(dt, fireMode)
  local angle, dir = activeItem.aimAngleAndDirection(0.25, activeItem.ownerAimPosition())
  if fireMode == "none" then
    angle = self.idleAngle
  end

  activeItem.setArmAngle(angle)
  activeItem.setFacingDirection(dir)
  dir = mcontroller.facingDirection()
  
  animator.resetTransformationGroup(Hash_Brown)
  animator.scaleTransformationGroup(Hash_Brown, {self.scale * mcontroller.facingDirection(), self.scale}, self.offset)
  animator.rotateTransformationGroup(Hash_Brown, -angle * 0.5)
end

function activate()
  if self.pitchNRand then
    animator.setSoundPitch(Hash_Brown, sb.nrand(self.pitchNRand[1], self.pitchNRand[2]))
  end
  animator.playSound(Hash_Brown)
end
