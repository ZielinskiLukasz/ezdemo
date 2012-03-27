{* Product - Full view *}

{set scope=global persistent_variable=hash('left_menu', false(),
                                           'extra_menu', false())}

<form method="post" action={"content/action"|ezurl}>
<section class="content-view-full">
    <article class="class-product">

        <div class="attribute-header">
            <h1>{$node.name|wash()}</h1>
        </div>
        
        {if $node.data_map.image.has_content}
            <div class="attribute-image full-head">
                {attribute_view_gui attribute=$node.data_map.image image_class=productimage}

                {if $node.data_map.caption.has_content}
                    <div class="attribute-caption">
                        {attribute_view_gui attribute=$node.data_map.caption}
                    </div>
                {/if}
            </div>
        {/if}

        <div class="attribute-product-number">
           {attribute_view_gui attribute=$node.object.data_map.product_number}
        </div>

        <div class="attribute-short">
           {attribute_view_gui attribute=$node.object.data_map.short_description}
        </div>

        <div class="attribute-long">
           {attribute_view_gui attribute=$node.object.data_map.description}
        </div>

        <div class="attribute-price">
          <p>
           {attribute_view_gui attribute=$node.object.data_map.price}
          </p>
        </div>

        <div class="attribute-multi-options">
           {attribute_view_gui attribute=$node.object.data_map.additional_options}
        </div>

        {* Category. *}
        {def $product_category_attribute=ezini( 'VATSettings', 'ProductCategoryAttribute', 'shop.ini' )}
        {if and( $product_category_attribute, is_set( $node.data_map.$product_category_attribute ) )}
        <div class="attribute-long">
          <p>Category:&nbsp;{attribute_view_gui attribute=$node.data_map.$product_category_attribute}</p>
        </div>
        {/if}
        {undef $product_category_attribute}

        <div class="content-action">
            <input type="submit" class="defaultbutton" name="ActionAddToBasket" value="{"Add to basket"|i18n("design/ezdemodesign/full/product")}" />
            <input class="button" type="submit" name="ActionAddToWishList" value="{"Add to wish list"|i18n("design/ezdemodesign/full/product")}" />
            <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
            <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
            <input type="hidden" name="ViewMode" value="full" />
        </div>

       {* Related products. *}
       {def $related_purchase=fetch( 'shop', 'related_purchase', hash( 'contentobject_id', $node.object.id, 'limit', 10 ) )}
       {if $related_purchase}
        <div class="relatedorders">
            <h2>{'People who bought this also bought'|i18n( 'design/ezdemodesign/full/product' )}</h2>

            <ul>
            {foreach $related_purchase as $product}
                <li>{content_view_gui view=text_linked content_object=$product}</li>
            {/foreach}
            </ul>
        </div>
       {/if}
       {undef $related_purchase}
   </article>
</section>
</form>
