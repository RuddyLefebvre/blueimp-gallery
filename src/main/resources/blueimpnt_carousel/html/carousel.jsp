<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<template:addResources type="css" resources="blueimp-gallery/blueimp-gallery.css"/>
<template:addResources type="css" resources="blueimp-gallery/blueimp-gallery-indicator.css"/>
<template:addResources type="css" resources="blueimp-gallery/blueimp-gallery-video.css"/>
<template:addResources type="javascript" resources="blueimp-gallery/blueimp-helper.js"/>
<template:addResources type="javascript" resources="blueimp-gallery/blueimp-gallery.js"/>
<template:addResources type="javascript" resources="blueimp-gallery/blueimp-gallery-fullscreen.js"/>
<template:addResources type="javascript" resources="blueimp-gallery/blueimp-gallery-indicator.js"/>
<template:addResources type="javascript" resources="blueimp-gallery/blueimp-gallery-video.js"/>
<template:addResources type="javascript" resources="blueimp-gallery/blueimp-gallery-vimeo.js"/>
<template:addResources type="javascript" resources="blueimp-gallery/blueimp-gallery-youtube.js"/>
<template:addResources type="javascript" resources="blueimp-gallery/jquery.blueimp-gallery.js"/>

<template:addResources>
    <script>
        $(document).ready(function() {
            setTimeout(function(){
                blueimp.Gallery(document.getElementById('links_${currentNode.identifier}').getElementsByTagName('a'),
                        {
                            container: '#blueimp-gallery-carousel_${currentNode.identifier}',
                            carousel: true
                        }
                );
            }, 1);
        });
    </script>
</template:addResources>


<c:if test="${(renderContext.editMode and not fn:startsWith(currentNode.path, '/modules')) or fn:contains(renderContext.editModeConfigName, 'studio')}">
    <template:include view="edit"/>
</c:if>

<div id="blueimp-gallery-carousel_${currentNode.identifier}" class="blueimp-gallery blueimp-gallery-carousel">
    <div class="slides"></div>
    <h3 class="title"></h3>
    <a class="prev">‹</a>
    <a class="next">›</a>
    <a class="play-pause"></a>
    <ol class="indicator"></ol>
</div>

<c:set var="blueimpCarouselChildren" value="${jcr:getChildrenOfType(currentNode, 'blueimpnt:carouselImageItem,blueimpnt:carouselVideoItem,blueimpnt:carouselOnlineVideoItem')}"/>
<div id="links_${currentNode.identifier}" style="display: none;">
    <c:forEach items="${blueimpCarouselChildren}" var="child" varStatus="status">
        <template:module node="${child}" editable="true"/>
    </c:forEach>
</div>