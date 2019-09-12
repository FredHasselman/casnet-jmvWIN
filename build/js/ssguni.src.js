
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"y1","title":"Variable 1","type":"Variable","rejectUnusedLevels":false,"suggested":["nominal"],"permitted":["factor"],"default":null,"description":{"R":"An unordered categorical state variable"}},{"name":"time","title":"Time (optional)","type":"Variable","rejectUnusedLevels":true,"suggested":["ordinal","continuous"],"permitted":["numeric"],"default":null,"description":{"R":"A variable indicating time"}},{"type":"String","name":"v1_labels","default":""},{"type":"Integer","name":"v1_Nstates","default":0},{"name":"ssgUNIlag","title":"Lagged analysis","type":"Number","default":1},{"type":"Number","name":"MinReturns","title":"Minimum number of returns","default":2},{"type":"Number","name":"MaxReturnTime","title":"Maximum return time","default":0},{"type":"Number","name":"MaxReturnVisits","title":"Maximum number of return visits","default":0},{"type":"Number","name":"MinEventDuration","title":"Minimum event duration","default":0},{"type":"Number","name":"MinCellDuration","title":"Minimum cell duration","default":0}];

const view = function() {
    
    

    View.extend({
        jus: "2.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Univariate State Space Grid",
    jus: "2.0",
    type: "root",
    stage: 0, //0 - release, 1 - development, 2 - proposed
    controls: [
		{
			type: DefaultControls.VariableSupplier,
			typeName: 'VariableSupplier',
			persistentItems: false,
			stretchFactor: 1,
			controls: [
				{
					type: DefaultControls.TargetLayoutBox,
					typeName: 'TargetLayoutBox',
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							typeName: 'VariablesListBox',
							name: "y1",
							maxItemCount: 1,
							isTarget: true
						}
					]
				}
			]
		},
		{
			type: DefaultControls.CollapseBox,
			typeName: 'CollapseBox',
			label: "Variable 1: Specify categories",
			collapsed: true,
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "How many unique states can be observed for Variable 1? (optional)",
					controls: [
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "v1_Nstates",
							label: "N unique states",
							format: FormatDef.number
						}
					]
				},
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Provide state labels seperated by comma's (optional)",
					controls: [
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "v1_labels",
							label: "State labels",
							format: FormatDef.string,
							width: "largest"
						}
					]
				}
			]
		},
		{
			type: DefaultControls.VariableSupplier,
			typeName: 'VariableSupplier',
			persistentItems: false,
			stretchFactor: 1,
			controls: [
				{
					type: DefaultControls.TargetLayoutBox,
					typeName: 'TargetLayoutBox',
					label: "Time (optional)",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							typeName: 'VariablesListBox',
							name: "time",
							maxItemCount: 1,
							isTarget: true
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Lagged analysis",
					controls: [
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "ssgUNIlag",
							format: FormatDef.number
						}
					]
				}
			]
		},
		{
			type: DefaultControls.CollapseBox,
			typeName: 'CollapseBox',
			label: "State measures",
			collapsed: true,
			controls: [
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "MinReturns",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "MaxReturnTime",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "MaxReturnVisits",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "MinEventDuration",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "MinCellDuration",
					format: FormatDef.number
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
