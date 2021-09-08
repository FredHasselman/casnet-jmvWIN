
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"deps","title":"Select variables","type":"Variables"},{"name":"dataDone","title":"Check to run analysis with selected variables","type":"Bool","default":false},{"name":"minScale","title":"Minimum scale value","type":"List","options":[{"name":"autoMin","title":"Use minimum of data"},{"name":"userMin","title":"Enter value"}],"default":"autoMin"},{"name":"userMinScale","title":"Minimum scale value","type":"Number","default":0},{"name":"maxScale","title":"Maximum scale value","type":"List","options":[{"name":"autoMax","title":"Use maximum of data"},{"name":"userMax","title":"Enter value"}],"default":"autoMax"},{"name":"userMaxScale","title":"Maximum scale value","type":"Number","default":0},{"name":"win","title":"Window size","type":"Number","default":7},{"name":"Order","title":"Variable order in plots","type":"List","options":[{"name":"data","title":"Data file order."},{"name":"alpha","title":"Alphabetical"},{"name":"means","title":"Mean dynamic complexity"}],"default":"data"}];

const view = function() {
    
    this.handlers = { }

    View.extend({
        jus: "3.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Dynamic Complexity",
    jus: "3.0",
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
					label: "Select variables",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							typeName: 'VariablesListBox',
							name: "deps",
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
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "dataDone"
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			style: "inline",
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Minimum scale",
					controls: [
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "minScale_autoMin",
							optionName: "minScale",
							optionPart: "autoMin"
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "minScale_userMin",
							optionName: "minScale",
							optionPart: "userMin",
							controls: [
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "userMinScale",
									label: "Enter min. value",
									format: FormatDef.number,
									enable: "(minScale_userMin)"
								}
							]
						}
					]
				},
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Maximum scale",
					controls: [
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "maxScale_autoMax",
							optionName: "maxScale",
							optionPart: "autoMax"
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "maxScale_userMax",
							optionName: "maxScale",
							optionPart: "userMax",
							controls: [
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "userMaxScale",
									label: "Enter max. value",
									format: FormatDef.number,
									enable: "(maxScale_userMax)"
								}
							]
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			style: "inline",
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Size of the sliding window",
					controls: [
						{
							type: DefaultControls.LayoutBox,
							typeName: 'LayoutBox',
							margin: "large",
							controls: [
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "win",
									format: FormatDef.number
								}
							]
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			style: "inline",
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Complexity Resonance Plot & Cumulative Complexity Peaks",
					controls: [
						{
							type: DefaultControls.LayoutBox,
							typeName: 'LayoutBox',
							margin: "large",
							controls: [
								{
									type: DefaultControls.ComboBox,
									typeName: 'ComboBox',
									name: "Order"
								}
							]
						}
					]
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
