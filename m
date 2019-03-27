Return-Path: <SRS0=dQwf=R6=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC59C43381
	for <linux-rtc@archiver.kernel.org>; Wed, 27 Mar 2019 01:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20B52075D
	for <linux-rtc@archiver.kernel.org>; Wed, 27 Mar 2019 01:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sF8zuIRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfC0BC1 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:02:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37163 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfC0BC1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 26 Mar 2019 21:02:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id q6so2455606pll.4;
        Tue, 26 Mar 2019 18:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rNANlHwOGEgCnrWo9ynabKqHn9FlqsmS+h6Qq3AFCHE=;
        b=sF8zuIRlxeUPfduxRC33yGpETr6K61hgOFS8YZqLt/G7SLLC/pZuqjsaIs1FdzzsSP
         yJuEAg21qqghxKapvUGSP8+pbYLVn9RjXA7zk0RFKhjXM/4QqW+mVHn3Fng0taTqwSTh
         H8C92EzDo5kkVJVf1hV/2uZmrDYCOZXvXPiAiS5MjGF60LJv298Qf9BblINpdf7J1DRO
         sjBTIMJaON/u8KpikcCIvMxCOOeCupK60YhmDiX5yvRKcQy6eZQb/zqSBjto2CFFq/6D
         erIIAoC3uIbkOKhHib48bXZv/mEfCH4U3g0MyqojPhdsKhd9lrGMX/KYBWH8fgCOTy/b
         oGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=rNANlHwOGEgCnrWo9ynabKqHn9FlqsmS+h6Qq3AFCHE=;
        b=nGjFk4yqxLVMyHO3kE2S3Eu/sqEKv8g0GljkofOeKekr5qvhWzfo3zfJbpnVmO8HRs
         itgk0yl6ozSwYT0nEBqvwSTR8keGbLDQQuoLPWACWPuVIv+szV6PAZRkjf/dj4WvLDtX
         4mdXB24gAUXoAf4Zs27sBlDOmQ4i+Y2jN1hx2fUXWa8wZXM3p/pUymJIEEga1rnTx3fF
         ID9xeOFzBBFUHVIMQtK1KOO2UmZsF0AI0mptxVRAz9dBSMMsJKkrjeJyw14Yz+t7qX4O
         O+ssGyml7RO+uOUZLZ93TrACy7DSZQVEyX+slcWfFtj2QjYaQWl7t63x8DOsZlDaARet
         AKDg==
X-Gm-Message-State: APjAAAVymha+64vUgjDc2UCeqIildj1z/gFRxA4IJsMlKhBCVZu4laZS
        WtJr655kuDlzgwNY2IWCGiU=
X-Google-Smtp-Source: APXvYqzIanJX2S/MsEyVYCq6vakUIID8Big/EEwLLJ89oOMTQDCu2jkwaHjIHHGwstmF/1Hj143kvQ==
X-Received: by 2002:a17:902:2865:: with SMTP id e92mr34786538plb.312.1553648546673;
        Tue, 26 Mar 2019 18:02:26 -0700 (PDT)
Received: from voyager.jms.id.au ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id h11sm21990780pgq.57.2019.03.26.18.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 18:02:26 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation); Wed, 27 Mar 2019 11:32:17 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH v3 0/2] rtc: Add ASPEED RTC driver
Date:   Wed, 27 Mar 2019 11:32:13 +1030
Message-Id: <20190327010215.10231-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

v3: Remove unnecessary locking, use ptR
v2: Address review from Alexandre

Joel Stanley (2):
  dt-bindings: rtc: Add on-chip ASPEED RTC documentation
  rtc: Add ASPEED RTC driver

 .../devicetree/bindings/rtc/rtc-aspeed.txt    |  22 +++
 drivers/rtc/Kconfig                           |  11 ++
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-aspeed.c                      | 138 ++++++++++++++++++
 4 files changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
 create mode 100644 drivers/rtc/rtc-aspeed.c

-- 
2.20.1

