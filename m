Return-Path: <SRS0=i680=R4=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BA7C43381
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 13:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3704C2084D
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 13:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rccxnf/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfCYNcW (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:32:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43212 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCYNcW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 25 Mar 2019 09:32:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so6431659pfd.10;
        Mon, 25 Mar 2019 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aaOBUNSIm700DIjLJCNpAtOm6+4HU//hwZxNLzJTwfU=;
        b=Rccxnf/68/ixRAquiQh3RRHlW7JmLn9sjD5e/NIcZ7HLkQvoBYfcu2nGAsBDcCUC8d
         vwokpxlhKSv0kIiiBOlBGMTB9v6bEHVg9avdoo7z4YOV8QHQq0tuMgqdWfu+fjR5AJB0
         KyKl5mUUb0mSfvsLsBVENt+R2gIP98Kp6OTPdtnESLgy3nkeAWsHSro5bFhxsP9G5kNm
         VGrZ6Gx43n9CKoWsWBhEQOzn/kzZ5uF6gpw0jbuCZOiPSCiVT/DfP0zQ+0TXBCMFOBU2
         NPTLiAv/G/Tm2DtWJ303YhtvzfdULch6jpQcGPBgoMwB0B3SfL5hPL/QWZPKHi398zv1
         FS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aaOBUNSIm700DIjLJCNpAtOm6+4HU//hwZxNLzJTwfU=;
        b=qy/QXAUqrLyMTM765gOWlbsXiM0Z8f3Un1uf9qS1fZrgu8eUcIQ3MKjWFAwAIU9jSK
         Lygx1ivQpR72YjPtaS5H0+3E7QfSTb2updU6XXiUfXc0iNlWNsCGKiFQus6XVy5bqFsZ
         HZpQaemwlydLR7WQ+9Ww9OOqq6SKAqsjaAkvCAxrwy7Mv3bLEcvYNEevgpc7zCMtJV8x
         hDt9tlOFqZ4ufA2LyLtcwEc5+eSOuJ6dDgFO5cBikPa0oo/T3CFlsvv9it4IHACMkTv9
         BsVOgytzYc9fD+2hICGa5jIqqXi5Qvd17f9yB4fKwgpHfzkSjXw3VX2qYh/rHgKAc9EK
         hVTA==
X-Gm-Message-State: APjAAAVDGr3dTDH8PC6CtQGPQ0IIMnzZR4Ttuxcoo54UisXTAa657Kn/
        9+q2NVlzazlRH1FNHE6zspk=
X-Google-Smtp-Source: APXvYqxAQWtYaBd+sLDQDSzxBZHuaO4zbxCGKZnmlECVC36DzGls5eg7x9HNa6nYU+yxtNhmZxsq7Q==
X-Received: by 2002:a62:ea0f:: with SMTP id t15mr24500488pfh.124.1553520741971;
        Mon, 25 Mar 2019 06:32:21 -0700 (PDT)
Received: from voyager.jms.id.au ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id m25sm7947423pfa.175.2019.03.25.06.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 06:32:21 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation); Tue, 26 Mar 2019 00:02:13 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 1/2] dt-bindings: rtc: Add on-chip ASPEED RTC documentation
Date:   Tue, 26 Mar 2019 00:01:58 +1030
Message-Id: <20190325133159.10653-2-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190325133159.10653-1-joel@jms.id.au>
References: <20190325133159.10653-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Describe the RTC as used in the ASPEED BMC SoCs.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/rtc/rtc-aspeed.txt    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-aspeed.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
new file mode 100644
index 000000000000..f9f7defd557e
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
@@ -0,0 +1,19 @@
+ASPEED BMC RTC
+==============
+
+Required properties:
+ - compatible: should be one of the following
+   * aspeed,ast2400-rtc for the ast2400
+   * aspeed,ast2500-rtc for the ast2500
+   * aspeed,ast2600-rtc for the ast2600
+
+ - reg: physical base address of the controller and length of memory mapped
+   region
+
+Example:
+
+   rtc@1e781000 {
+           compatible = "aspeed,ast2400-rtc";
+           reg = <0x1e781000 0x18>;
+           status = "disabled";
+   };
-- 
2.20.1

