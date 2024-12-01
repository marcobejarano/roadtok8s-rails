class Api::V1::HelloK8sController < ApplicationController
  def welcome_to_k8s
    render json: { "Let's": "go", "to": "k8s" }
  end
end
