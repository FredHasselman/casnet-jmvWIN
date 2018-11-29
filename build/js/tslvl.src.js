
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"dep","title":"Dependent Variable","type":"Variable"},{"name":"group","title":"Grouping Variable","type":"Variable"},{"name":"alt","title":"Alternative hypothesis","type":"List","options":[{"title":"Not equal","name":"notequal"},{"title":"One greater","name":"onegreater"},{"title":"Two greater","name":"twogreater"}],"default":"notequal"},{"name":"varEq","title":"Assume equal variances","type":"Bool","default":true}];

const view = View.extend({
    jus: "2.0",

    events: [

	]

});

view.layout = ui.extend({

    label: "Detect levels & peaks",
    jus: "2.0",
    type: "root",
    stage: 0, //0 - release, 1 - development, 2 - proposed
    controls: [
		{
			type: DefaultControls.VariableSupplier,
			persistentItems: false,
			stretchFactor: 1,
			controls: [
				{
					type: DefaultControls.TargetLayoutBox,
					label: "Dependent Variable",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							name: "dep",
							maxItemCount: 1,
							isTarget: true
						}
					]
				},
				{
					type: DefaultControls.TargetLayoutBox,
					label: "Grouping Variable",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							name: "group",
							maxItemCount: 1,
							isTarget: true
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			margin: "large",
			controls: [
				{
					type: DefaultControls.ComboBox,
					name: "alt"
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			margin: "large",
			controls: [
				{
					type: DefaultControls.CheckBox,
					name: "varEq"
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
