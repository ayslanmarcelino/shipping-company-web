module CtesHelper
  def emitter_collection
    Cte.pluck(:emitter)
              .compact
              .uniq
              .sort
  end
end
