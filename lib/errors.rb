module Errors
  class MoveOutBoundary < StandardError; end
  class PlaceOutBoundary < StandardError; end
  class RobotNotPlace < StandardError; end
  class InvalidAction < StandardError; end
  class WrongNumberArgs < StandardError; end
  class WrongPostionType < StandardError; end
  class InvalidDirection < StandardError; end
end
