$(document).ready(function(){

  var slugs_re = /\$([a-z_]{1,20})\$/g;
  var current_slugs = [];
  var trait_options_html = $("select#prop_traits").html();
  var hidden_introns = $("#hidden_introns");
  var introns_fieldset = $("fieldset#introns");

  $("textarea#task_material").change(function(){
    var new_current_slugs = [];
    var material = $(this).val();
    while ((res = slugs_re.exec(material)) !== null) {
      var slug = res[1];
      new_current_slugs.push(slug);
    }
    current_slugs = new_current_slugs;

    var introns_count = 0;

    // remove intron divs for slugs not anymore present
    introns_fieldset.find(".intron_slug").each( function(){
      var slug_idx = current_slugs.indexOf( $(this).val() );
      var intron_div = $(this).parents(".intron");
      var destroy_checkbox = intron_div.find(".intron_destroy");
      if ( slug_idx == -1) {
        // if old records, check destroy, else move to hidden part
        if (destroy_checkbox.size() > 0) {
          destroy_checkbox.attr("checked", "checked");
          intron_div.addClass("hide");
        } else {
          intron_div.detach().appendTo(hidden_introns);
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
    $("#hidden_introns .intron_slug").each( function(){
      var intron_div = $(this).parents(".intron");
      var slug_idx = current_slugs.indexOf( $(this).val() );
      if ( slug_idx > -1) {
        intron_div.detach().appendTo(introns_fieldset);
      }
      delete(current_slugs[slug_idx]);
    });

    // append intron divs for new slugs
    $.each(current_slugs, function(idx, slug){
      if (slug !== undefined) { // skip those deleted in previous step
        var prefix = "task_introns_attributes_" + introns_count;

        $("fieldset#introns").append(
          "<div class='intron row-fluid'>" +
            "<div class='trait span3'>" +
              "<label for='" + prefix + "_slug'>" + slug + "</label>" +
              "<input class='intron_slug' id='" + prefix + "_slug' " +
                "name='task[introns_attributes][" + introns_count + "][slug]' " +
                " type='hidden' value='" + slug + "'>" +
              "<select id='" + prefix + "_trait_id' class='intron_trait' " +
                "name='task[introns_attributes][" + introns_count + "][trait_id]'>" +
                trait_options_html +
              "</select>" +
            "</div>" +
            "<div class='variations span6'></div>" +
          "</div>"
        );
        introns_count++;
      }
    });

    rebindTraitSelects();

  });

  var rebindTraitSelects = function(){
    // $("fieldset#introns .intron_trait")
    $("fieldset#introns select").change(function(){
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
      $(this).parent().siblings(".variations").html( variations_html );
    });
  };

  rebindTraitSelects();
  $("fieldset#introns .intron:not(.with_initial_variations) select").change();

});