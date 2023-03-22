class AccountsController <ApplicationController
  def index
    render json: JSONAPI::Serializer.serialize(
      current_user.accounts.where.not(role: 1),
      namespace: Api::Lts,
      is_collection: true
    )
  end

  def show
    render json: JSONAPI::Serializer.serialize(Account.find_by_uuid(params[:id]), namespace: Api::Lts)
  end
  
  def create
    subaccount = Api::AccountsService.create_subaccount(
      current_user,
      account_params[:user_uuid]
    )

    render json: JSONAPI::Serializer.serialize(subaccount, namespace: Api::Lts)
  end

  def update
    account = Account.find_by_uuid(params[:id])
    verification = account.verifications.first

    if verification
      verification.update(external_uuid: account_params[:user_uuid])
    else
      account.verifications.create(external_uuid: account_params[:user_uuid])
    end

    render json: JSONAPI::Serializer.serialize(account, namespace: Api::Lts)
  end

  private

  def account_params
    params.require(:data).permit(:user_uuid)
  end
end
