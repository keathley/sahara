defmodule Sahara.Inventory.Item do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t()
        }
  defstruct [:id]

  field :id, 1, type: :string
end

defmodule Sahara.Inventory.Count do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          in_stock: non_neg_integer
        }
  defstruct [:in_stock]

  field :in_stock, 1, type: :uint32
end
