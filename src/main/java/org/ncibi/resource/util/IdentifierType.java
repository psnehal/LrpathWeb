package org.ncibi.resource.util;

public enum IdentifierType
{
	GENEID("geneId"), GENE_SYMBOL("geneSymbol"), OTHERID("otherId");

	private final String identifierName;

	private IdentifierType(String identifierName)
	{
		this.identifierName = identifierName;
	}

	public static IdentifierType toIdentifierType(String id)
	{
		for (IdentifierType i : IdentifierType.values())
		{
			if (i.identifierName.equals(id))
			{
				return i;
			}
		}

		return OTHERID;
	}

	public String identifierName()
	{
		return identifierName;
	}

}
