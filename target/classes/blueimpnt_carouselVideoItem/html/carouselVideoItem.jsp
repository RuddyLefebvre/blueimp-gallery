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

<c:set var="dataSources" value="["/>
<c:set var="mainType" value=""/>
<c:set var="dataPoster" value=""/>
<c:set var="mainHref" value=""/>
<c:if test="${not empty currentNode.properties.videoMP4}">
    <c:set var="mainType" value="${}"/>
    <c:set var="dataSources">${dataSources}{"href":"${currentNode.properties.videoMP4.node.url}", "type":"video/mp4"}</c:set>
</c:if>
<c:if test="${not empty currentNode.properties.videoOgg}">
    <c:if test="${dataSources.length() gt 1}">
        <c:set var="dataSources">${dataSources},</c:set>
    </c:if>
    <c:set var="dataSources">${dataSources}{"href":"${currentNode.properties.videoOgg.node.url}", "type":"video/ogg"}</c:set>
</c:if>
<c:if test="${not empty currentNode.properties.videoWebM}">
    <c:if test="${dataSources.length() gt 1}">
        <c:set var="dataSources">${dataSources},</c:set>
    </c:if>
    <c:set var="dataSources">${dataSources}{"href":"${currentNode.properties.videoWebM.node.url}", "type":"video/webm"}</c:set>
</c:if>
<c:set var="dataSources">${dataSources}]</c:set>

<a href="https://example.org/videos/fruits.mp4" title="${child.displayableName}"
   data-poster="" type=""
   data-sources='${dataSources}'>
    ${child.displayableName}
</a>