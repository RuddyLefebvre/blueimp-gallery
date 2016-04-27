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
<template:addResources type="css" resources="blueimp-gallery.min.css"/>
<template:addResources type="javascript" resources="blueimp-gallery.min.js"/>
<template:addResources type="javascript" resources="jquery.min.js"/>
<template:addResources>
    <script>
        $(document).ready(function() {
            <%--document.getElementById('links_${currentNode.identifier}').onclick = function (event) {--%>
                <%--event = event || window.event;--%>
                <%--var target = event.target || event.srcElement,--%>
                        <%--link = target.src ? target.parentNode : target,--%>
                        <%--options = {index: link, event: event},--%>
                        <%--links = this.getElementsByTagName('a');--%>
                <%--blueimp.Gallery(links, options);--%>
            <%--};--%>

            blueimp.Gallery(document.getElementById('links').getElementsByTagName('a'),
                {
                    container: '#blueimp-gallery-carousel_${currentNode.identifier}',
                    carousel: true
                }
            );
        });
    </script>
</template:addResources>

<div id="blueimp-gallery-carousel_${currentNode.identifier}" class="blueimp-gallery blueimp-gallery-controls blueimp-gallery-carousel">
    <div class="slides"></div>
    <h3 class="title"></h3>
    <a class="prev">‹</a>
    <a class="next">›</a>
    <a class="play-pause"></a>
    <ol class="indicator"></ol>
</div>

<c:set var="blueimpCarouselChildren" value="${jcr:getChildrenOfType(currentNode, 'blueimpnt:carouselImageItem,blueimpnt:carouselVideoItem')}"/>
<div id="links_${currentNode.identifier}">
    <c:forEach items="${blueimpCarouselChildren}" var="child" varStatus="status">
        <template:module node="${child}" editable="true"/>
    </c:forEach>
</div>

<c:if test="${renderContext.editMode}">
    <template:module path="*" nodeTypes="blueimpnt:carouselImageItem,blueimpnt:carouselVideoItem"/>
</c:if>