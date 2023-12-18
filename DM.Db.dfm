object DbModule: TDbModule
  Height = 145
  Width = 194
  object tblSqids: TFDMemTable
    OnCalcFields = tblSqidsCalcFields
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 38
    Top = 19
    object tblSqidsNumber: TSmallintField
      FieldName = 'Number'
    end
    object tblSqidsId: TStringField
      DisplayWidth = 50
      FieldKind = fkCalculated
      FieldName = 'Id'
      Size = 100
      Calculated = True
    end
  end
end
