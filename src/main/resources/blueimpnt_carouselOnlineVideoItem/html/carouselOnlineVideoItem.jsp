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

<c:set var="origin" value="${currentNode.properties.origin.string}"/>
<c:set var="videoID" value="${currentNode.properties.videoId.string}"/>

<c:set var="dataSources" value="["/>
<c:set var="videoUrl"/>
<c:set var="posterUrl"/>
<c:choose>
    <c:when test="${origin eq 'youtube'}">
        <c:set var="videoUrl" value="https://www.youtube.com/watch?v=${videoID}"/>
        <c:set var="posterUrl" value="https://img.youtube.com/vi/${videoID}/maxresdefault.jpg"/>
        <c:set var="dataSources">${dataSources}{"title":"${currentNode.displayableName}", "href":"${videoUrl}", "type":"text/html", "youtube":"${videoID}"}</c:set>
    </c:when>
    <c:otherwise>
        <c:set var="videoUrl" value="https://vimeo.com/${videoID}"/>
        <c:set var="posterUrl"/>
        <c:set var="dataSources">${dataSources}{"title":"${currentNode.displayableName}", "href":"${videoUrl}", "type":"text/html", "vimeo":"${videoID}"}</c:set>
        <template:addResources>
            <script>
                $(document).ready(function() {
                    $.ajax({
                        type:'GET',
                        url: 'http://vimeo.com/api/v2/video/${videoID}.json',
                        jsonp: 'callback',
                        dataType: 'jsonp',
                        success: function(data){
                            var thumbnail_src = data[0].thumbnail_large;
                            $('#thumb_${currentNode.identifier}').attr('src', thumbnail_src);
                            <%--var dataSources = JSON.parse($('#link_${currentNode.identifier}').attr('data-sources'));--%>
//                            dataSources[0].poster = thumbnail_src;
                            <%--$('#link_${currentNode.identifier}').attr('data-sources', JSON.stringify(dataSources));--%>
                        }
                    });
                });
            </script>
        </template:addResources>
    </c:otherwise>
</c:choose>
<c:set var="dataSources">${dataSources}]</c:set>

<a href="${videoUrl}" title="${currentNode.displayableName}" type="text/html"
   id="link_${currentNode.identifier}"
   data-sources="${fn:escapeXml(dataSources)}" data-${origin}="${videoID}" data-gallery>
    <img id="thumb_${currentNode.identifier}" src="${posterUrl}" alt="${currentNode.displayableName}">
</a>