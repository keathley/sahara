defmodule Sahara.Catalog.ItemReq do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t()
        }
  defstruct [:id]

  field :id, 1, type: :string
end

defmodule Sahara.Catalog.ItemsReq do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Sahara.Catalog.Item do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          description: String.t()
        }
  defstruct [:id, :name, :description]

  field :id, 1, type: :string
  field :name, 2, type: :string
  field :description, 3, type: :string
end

defmodule Sahara.Catalog.ItemsResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          items: [Sahara.Catalog.Item.t()]
        }
  defstruct [:items]

  field :items, 1, repeated: true, type: Sahara.Catalog.Item
end
