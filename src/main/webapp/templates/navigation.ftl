<#--
    navigation.ftl: header navigation.
    
    Created:    2017-09-07 11:27 by Christian Berndt
    Modified:   2017-10-30 21:54 by Christian Berndt
    Version:    1.0.5
-->

<#assign home_url = htmlUtil.escape(theme_display.getURLHome()) />
<#assign is_impersonated = themeDisplay.isImpersonated() />

<#if !home_url?has_content>
    <#assign home_url = company_url />
</#if>

<#if is_impersonated>
    <#assign do_as_user_id = paramUtil.getString(request, "doAsUserId") />
    <#assign home_url = httpUtil.addParameter(home_url, "doAsUserId", do_as_user_id) />
</#if>

<nav class="${nav_css_class} navbar navbar-default navbar-fixed-top" id="navigation" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".site-navigation" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
           
            <a class="navbar-brand ${logo_css_class}" href="${home_url}" title="<@liferay.language_format arguments="${site_name}" key="go-to-x" />">
            
                <#--  
                <img alt="${logo_description}" src="${company_logo}?v.1" />
                -->
                
                <#-- <#if show_site_name>  -->
                    <span class="brand-name site-name" title="<@liferay.language_format arguments="${company_name}" key="go-to-x" />">
                        ${company_name}
                    </span>
                <#-- </#if> -->
            </a>

        </div>
 
         <ul class="nav language">
            <li>
                <#assign VOID = freeMarkerPortletPreferences.setValue("portletSetupPortletDecoratorId", "barebone") />        
                <#assign VOID = freeMarkerPortletPreferences.setValue("displayStyle", "ddmTemplate_POPOVER-7.0.3") />        
                                    
                <@liferay_portlet["runtime"]
                    defaultPreferences="${freeMarkerPortletPreferences}"
                    portletProviderAction=portletProviderAction.VIEW
                    instanceId="NAVIGATION_LANGUAGE"
                    portletName="com_liferay_site_navigation_language_web_portlet_SiteNavigationLanguagePortlet" />
        
                <#assign VOID = freeMarkerPortletPreferences.reset() />
            </li>
        </ul>
        
        <ul aria-label="<@liferay.language key="site-pages" />" class="collapse nav navbar-collapse navbar-nav navbar-right site-navigation" role="menubar">
            <#list nav_items as nav_item>
                <#assign
                    data_toggle = ""
                    has_children = false 
                    nav_item_attr_has_popup = ""
                    nav_item_attr_selected = ""
                    nav_item_css_class = ""
                    nav_item_layout = nav_item.getLayout()
                    nav_link_css_class = ""
                />
                
                <#if nav_item.hasChildren()>
                    <#assign data_toggle = "data-toggle=\"dropdown\"" />                        
                    <#assign has_children = true />                        
                    <#assign nav_item_css_class = "dropdown"/>
                    <#assign nav_link_css_class = "dropdown-toggle"/>
                </#if>
                
    
                <#if nav_item.isSelected()>
                    <#assign
                        nav_item_attr_has_popup = "aria-haspopup='true'"
                        nav_item_attr_selected = "aria-selected='true'"
                        nav_item_css_class = nav_item_css_class + " active"
                    />
                </#if>
                
                <li ${nav_item_attr_selected} class="${nav_item_css_class}" id="layout_${nav_item.getLayoutId()}" role="presentation">
                    <a aria-labelledby="layout_${nav_item.getLayoutId()}" ${nav_item_attr_has_popup} href="${nav_item.getURL()}" ${nav_item.getTarget()} role="menuitem">
                        <span><@liferay_theme["layout-icon"] layout=nav_item_layout /> ${nav_item.getName()}</span>
                    </a>
                    <#if has_children>
                        <a aria-labelledby="layout_${nav_item.getLayoutId()}" class="${nav_link_css_class}" ${nav_item_attr_has_popup} ${data_toggle} href="${nav_item.getURL()}" ${nav_item.getTarget()} role="menuitem">
                            <span class="icon-angle-down"></span>
                        </a>
                        <ul class="dropdown-menu" role="menu">
                            <#list nav_item.getChildren() as nav_child>
                                <#assign
                                    nav_child_attr_selected = ""
                                    nav_child_css_class = ""
                                />
    
                                <#if nav_item.isSelected()>
                                    <#assign
                                        nav_child_attr_selected = "aria-selected='true'"
                                        nav_child_css_class = "selected"
                                    />
                                </#if>
    
                                <li ${nav_child_attr_selected} class="${nav_child_css_class}" id="layout_${nav_child.getLayoutId()}" role="presentation">
                                    <a aria-labelledby="layout_${nav_child.getLayoutId()}" href="${nav_child.getURL()}" ${nav_child.getTarget()} role="menuitem">${nav_child.getName()}</a>
                                </li>
                            </#list>
                        </ul>
                    </#if>                        
                </li>
                              
            </#list>

            <li>
                <#assign VOID = freeMarkerPortletPreferences.setValue("displayDepth", "1") />        
                <#assign VOID = freeMarkerPortletPreferences.setValue("portletSetupPortletDecoratorId", "barebone") />        
                                 
                <@liferay_portlet["runtime"]
                    defaultPreferences="${freeMarkerPortletPreferences}"
                    portletProviderAction=portletProviderAction.VIEW
                    instanceId="NAVIGATION_SITE_MAP"
                    portletName="com_liferay_site_navigation_site_map_web_portlet_SiteNavigationSiteMapPortlet" />
        
                <#assign VOID = freeMarkerPortletPreferences.reset() />            
            </li>
        </ul>
    </div>
</nav>
