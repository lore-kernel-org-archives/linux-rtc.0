Return-Path: <SRS0=i680=R4=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E2CC43381
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 13:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45392084D
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 13:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ozkkpv1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfCYNcQ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:32:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36743 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbfCYNcN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 25 Mar 2019 09:32:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id r124so6593187pgr.3;
        Mon, 25 Mar 2019 06:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OlALERb92juhPWZED/WKJ4fZx3V92Uf602P67UDrYyg=;
        b=Ozkkpv1jm+cNRquYQLTOy4x6830tJhkyxVqV8AieN5krbTdmwn+pHeCfNOj75JtgmD
         jfhkGu+gTYPFKlV/WmqyLmRiupQGlARGh+oPY/jEoqfKaxPUd5NTJpP/zERkMF64qJI6
         0fTDocRFvV32jcUTHrGx/YX4U20ov9gBRMInzPkh6RcD/pwl1QLlNtgaG5lQ6BZMb9ND
         TufROok+xt3WuLqcVGx7ipakvwVTnY6OJ4X5Os7vzuI0uYoPXquHNMQXN2qs8u7GYasz
         ug6G0TMC0JYO1iNvZkAUtRIc8S8dxjloLKsyB3W0EwZ9m9Ex2+EpalcgnlazzN0EIpj7
         cMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OlALERb92juhPWZED/WKJ4fZx3V92Uf602P67UDrYyg=;
        b=JtuInRbj/BpRd85ppF3FMVcXmzUWIF7ILo38KQEpVtKUAXJ14/o5WboDZd7FA9iO9t
         4l/8TclX4j9++xQ5OUs+M/V6X0ojg0AB6E/mDTLdjHQ4jnNy2rsMr0afosbENZKycHxH
         8M/hLsM0tog/bw8IFKPdFB8LWjsxDjHWWUjt0AcnAHvpG0pEQGxG6a2CvOdnvDeDSm1n
         JO+LI3ySoCcUgbjdiDuFJrD8Ep5kPR7XXlIxjNEg2F0uTcjMvkUN/KNMGYnVVvxLOEud
         HnYqqn0M0Qm3G8eooUYF3ZLtbWhy0tb8WSuAQW8A5Bkw3dNt5cnuVCYTcTgwqNGJ5VcO
         MBLQ==
X-Gm-Message-State: APjAAAXahiGjx1WLtAhWm92UdL376e+YZAAZTOJMdz+B1h/r1khtQzXc
        cyUgbollYgd0X56nNznjKF0=
X-Google-Smtp-Source: APXvYqzsKE+p5Qd9nNqpe/NDvZrPf9eIOAtD66v8RttA1LjJo1EVXr3yoggUKNcUoEZ5hnFWVt7yzw==
X-Received: by 2002:a63:5259:: with SMTP id s25mr21986914pgl.230.1553520732751;
        Mon, 25 Mar 2019 06:32:12 -0700 (PDT)
Received: from voyager.jms.id.au ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id o2sm24647004pgq.29.2019.03.25.06.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 06:32:12 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation); Tue, 26 Mar 2019 00:02:04 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 0/2] rtc: Add ASPEED RTC driver
Date:   Tue, 26 Mar 2019 00:01:57 +1030
Message-Id: <20190325133159.10653-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

I finally found some time to send a v2 for this one. Thanks Alexandre
for the review back in October.

v2: Address review from Alexandre

Joel Stanley (2):
  dt-bindings: rtc: Add on-chip ASPEED RTC documentation
  rtc: Add ASPEED RTC driver

 .../devicetree/bindings/rtc/rtc-aspeed.txt    |  19 +++
 drivers/rtc/Kconfig                           |  10 ++
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-aspeed.c                      | 152 ++++++++++++++++++
 4 files changed, 182 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
 create mode 100644 drivers/rtc/rtc-aspeed.c

-- 
2.20.1

