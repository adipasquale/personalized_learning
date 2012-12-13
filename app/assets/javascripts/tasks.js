$(document).ready(function(){

  var slugs_re = /\$([a-z_]{1,20})\$/g;
  var current_slugs = [];
  var trait_options_html = $("select#prop_traits").html();
  var introns_fieldset = $("#introns .introns_container");
  var $material = $("textarea#task_material");

  var refreshIntronsFields = function(params){

    // parse text to extract slugs
    var new_current_slugs = [];
    while ((res = slugs_re.exec(params.content)) !== null) {
      var slug = res[1];
      if (new_current_slugs.indexOf(slug) == -1) {
        new_current_slugs.push(slug);
      }
    }
    current_slugs = new_current_slugs;

    // remove intron divs for slugs not anymore present
    var introns_count = 0;
    params.introns_container.find(".intron_slug").each( function(){
      var slug_idx = current_slugs.indexOf( $(this).val() );
      var intron_div = $(this).parents(".intron");
      var destroy_checkbox = intron_div.find(".intron_destroy");
      if ( slug_idx == -1) {
        // if old records, check destroy, else move to hidden part
        if (destroy_checkbox.size() > 0) {
          destroy_checkbox.attr("checked", "checked");
          intron_div.addClass("hide");
        } else {
          console.log("detaching", intron_div, params.hidden_introns);
          intron_div.detach().appendTo(params.hidden_introns);
        }
      } else {
        if (destroy_checkbox.size() > 0) {
          destroy_checkbox.removeAttr("checked");
          intron_div.removeClass("hide");
        }
        delete(current_slugs[slug_idx]);
      }
      introns_count++;
    });

    // retreive new introns forms that were previously hidden
    params.hidden_introns.find(".intron_slug").each( function(){
      var intron_div = $(this).parents(".intron");
      var slug_idx = current_slugs.indexOf( $(this).val() );
      if ( slug_idx > -1) {
        intron_div.detach().appendTo(params.introns_container);
      }
      delete(current_slugs[slug_idx]);
    });

    // append intron divs for new slugs
    $.each(current_slugs, function(idx, slug){
      if (slug !== undefined) { // skip those deleted in previous step
        var id_prefix = params.id_prefix + "_introns_attributes_" + introns_count;
        var name_prefix = params.name_prefix + "[introns_attributes][" + introns_count + "]";

        params.introns_container.append(
          "<div class='intron row-fluid'>" +
            "<div class='trait span6'>" +
              "<label for='" + id_prefix + "_slug'>" + slug + "</label>" +
              "<input class='intron_slug' id='" + id_prefix + "_slug' " +
                "name='" + name_prefix + "[slug]' " +
                " type='hidden' value='" + slug + "'>" +
              "<select id='" + id_prefix + "_trait_id' class='intron_trait' " +
                "name='" + name_prefix + "[trait_id]'>" +
                trait_options_html +
              "</select>" +
            "</div>" +
            "<div class='contents span6'>" +
              "<label for='" + id_prefix + "_traditional_content'>Traditional Content</label>" +
              "<input id='" + id_prefix + "_traditional_content' type='text' " +
              " name='" + name_prefix + "[traditional_content]' />" +
              "<div class='variations'></div>" +
            "</div>" +
          "</div>"
        );
        introns_count++;
      }
    });

    rebindTraitSelects();
  };

  var commonRefresh = function(){
    var content = $("textarea#task_material").val();
    $("#questions .question_text, #questions .choice_text").each(function(){
      content += "\n" + $(this).val();
    });
    refreshIntronsFields({
      "name_prefix": "task", "id_prefix": "task",
      "content" : content, "introns_container": $("#introns_from_task"),
      "hidden_introns": $("#hidden_introns_from_task") });
  };

  $("textarea#task_material").change(function(){
    commonRefresh();
    updatePreview( $(this).val() );
  });

  $("#questions .question_text, #questions .choice_text").change(function(){
    commonRefresh();
  });

  var rebindTraitSelects = function(){
    introns_fieldset.find("select").change(function(){
      var variation_count = 0;
      var variations_html = "";
      var id_prefix = $(this).siblings(".intron_slug").attr('id').split("_slug")[0];
      var name_prefix = $(this).siblings(".intron_slug").attr('name').split("[slug]")[0];
      $("#prop_variations .trait[data-id=" + $(this).val() + "] .option").each(function(){
        var id_prefix_o = id_prefix + "_variations_attributes_" + variation_count;
        var name_prefix_o = name_prefix + "[variations_attributes][" + variation_count + "]";
        variations_html +=
          "<label for='" + id_prefix_o +"_content'>" +
            $(this).data("value") +
          "</label>" +
          "<input  id='" + id_prefix_o +"_content'" +
            "name='" + name_prefix_o + "[content]' type='text'/>" +
          "<input  id='" + id_prefix_o +"_option_id'" +
            "name='" + name_prefix_o + "[option_id]' type='hidden' " +
            "value='" + $(this).data('id') + "'/>";
          variation_count++;
      });
      $(this).parents(".intron").find(".variations").html( variations_html );
    });
  };

  // replaces material introns with testuser user_trait value or with the
  // first variation content if the trait has options
  var updatePreview = function(material){
    if (material === undefined) material = $("textarea#task_material").val();
    introns_fieldset.find(".intron:not(.hide)").each(function(){
      var trait_id = $(this).find("select").val();
      var intron_slug = $(this).find(".intron_slug").val();
      var preview_value = window.preview_traits[parseInt(trait_id, 10)];
      if ( preview_value === undefined || preview_value === "") {
        preview_value = $(this).find("input[type='text']:first").val();
      }
      if ( preview_value !== undefined) {
        material = material.replace(
          new RegExp("\\$" + intron_slug + "\\$", 'g'),
          "<span class='exon' title='" + intron_slug + "'>" + preview_value + "</span>"
        );
      }
    });
    $(".task_material").html(material);
  };

  // Bind the Add question and choice buttons
  $(".new_choice").click(function(){
    var parent = $(this).closest(".choices");
    parent.find(".choice_row.hide:first").removeClass("hide");
    if( parent.find(".choice_row.hide").size() === 0 ) {
      $(this).parent("div").remove();
    }
  });
  $(".new_question").click(function(){
    $(".question_row.hide:first").removeClass("hide");
    if( $(".question_row.hide").size() === 0 ) {
      $(this).parents(".row-fluid").detach();
    }
  });

  rebindTraitSelects();
  introns_fieldset.find(".intron:not(.with_initial_variations) select").change();

  updatePreview();

});