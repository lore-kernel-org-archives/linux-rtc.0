Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271E2CCA480
	for <linux-rtc@archiver.kernel.org>; Wed, 22 Jun 2022 05:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356867AbiFVFLZ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 22 Jun 2022 01:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356591AbiFVFLV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 22 Jun 2022 01:11:21 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C2C35DD0;
        Tue, 21 Jun 2022 22:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655874680; x=1687410680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=/DbzckqGmRxb/3mPVzWNJSUCm2EB7QZeWOitKJTzFWg=;
  b=fkfMPdxaIQpwr8l6CnuqaI9DJ9KVYcsqkxZnJEdEX18dNwJpif8rRkTd
   Co3IXfKVfnureiIi7xLuVCQOECpJ7ct7kag9f/eGfxUQqi0ju6+d8Z4gx
   UDpbJroL+PonVXpsTaXV/cdD8iH3SHCctIjcRtIkpDj0Xsi1mf2hNxaIw
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Jun 2022 22:11:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 22:11:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 21 Jun 2022 22:11:19 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 21 Jun 2022 22:11:15 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <quic_tsoni@quicinc.com>
Subject: [PATCH 2/2] dt-bindings: rtc: qcom-pm8xxx-rtc: Update the maintainers section
Date:   Wed, 22 Jun 2022 10:40:39 +0530
Message-ID: <1655874639-11273-3-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655874639-11273-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1655874639-11273-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Update the maintainers section with latest mail ID.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
 Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
index 6fa7d9f..23ab5bb 100644
--- a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm PM8xxx PMIC RTC device
 
 maintainers:
-  - Satya Priya <skakit@codeaurora.org>
+  - Satya Priya <quic_c_skakit@quicinc.com>
 
 properties:
   compatible:
-- 
2.7.4

