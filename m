Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3EDC433EF
	for <linux-rtc@archiver.kernel.org>; Wed, 22 Jun 2022 05:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiFVFLB (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 22 Jun 2022 01:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356667AbiFVFLB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 22 Jun 2022 01:11:01 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C0E35DC1;
        Tue, 21 Jun 2022 22:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655874660; x=1687410660;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=IUXjddSYc3lc18pbT0qmDyWfIkOKQ+bd9LurAEtuui0=;
  b=Do9MpXwLl3w/oK6V3CvL9UGCTybzyEZv6dQjxpvnBAiH8iFZVDd9fQnf
   mz0M7vniv3JyFpJP9mM8ZkqLWb5g//gW7N4x6mWWXKPZ+l/r6HOtNyds6
   oOFEQPIecYX8VwB3J9fc3+8B/eWXh1QYOQYpvnhBzzQ81o0Sa0wgIfV+w
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Jun 2022 22:11:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 22:10:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 21 Jun 2022 22:10:59 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 21 Jun 2022 22:10:55 -0700
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
Subject: [PATCH 0/2] Update the binding documents with latest mail ID
Date:   Wed, 22 Jun 2022 10:40:37 +0530
Message-ID: <1655874639-11273-1-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Satya Priya (2):
  dt-bindings: mfd: qcom-pm8xxx: Update the maintainers section
  dt-bindings: rtc: qcom-pm8xxx-rtc: Update the maintainers section

 Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml     | 2 +-
 Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4

