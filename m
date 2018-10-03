Return-Path: <SRS0=Sf1+=MP=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E0EC64EBC
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Oct 2018 13:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF7020684
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Oct 2018 13:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXMC+ZEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF7020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeJCUUc (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:20:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33867 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJCUUc (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 3 Oct 2018 16:20:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id q19-v6so5380241edr.1
        for <linux-rtc@vger.kernel.org>; Wed, 03 Oct 2018 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=heHc/2PWw0Y6QZdTVwnUBDABt2yKvmOih/qLRwAwhN4=;
        b=vXMC+ZEigc7bwLu491ApkoEsFrwGSgqk0FXU7WkrXUT7eAbM5Rkpjz5N3dw6W2pTPn
         HGg76otVU6xyaGorOMEgyzU53A9RLebbkOIuUreafCcKFeLblgQmaQGfhIVrqy0XZr3u
         qoerdHbPhuxLrWhUTCldx3OwiJpgVNCmShch6Afb8HqRVSInAkgxqfp9XhFiuekyCT2C
         duE61taVDATV7pQdGp2h9gD4ZYEFDdbilM8GQJs67ARUWfDcRJaT1/mGZUIXUmUdGYkq
         pB1cQeB2sbclbgVCvenT1kApkqviqaWbnxxKxsdfVC/DCwnQfHwvWiM8qc0MwWevo6wQ
         WbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=heHc/2PWw0Y6QZdTVwnUBDABt2yKvmOih/qLRwAwhN4=;
        b=I/VJNZi5hxjNWVli/Wp2pFXSHW5fgEUq3bn1RyWs6t1WOm8pXxnA/ribqgdlzbJQG/
         xdB2zJbL6T8OK9QVa0jFRTeI5F5H2JVfaicZtzQVz6XYrHMQeOuRpef+maxx45KEDVnZ
         6Q3jYj7+h7QdYUga56AnyhYBgJ2GNtgc0wD2GKQY6DyRx5/Myt0UaU4uMF8fegxsmIfX
         HAJEYc0FnHDksQnAZJJHyIGQcOhk6X+Ac/Szla4FoVPX/ztg95MaROKPOLJxCN8nvfV2
         1JOE6XSK0KB461Ra0cY2SILjkULQZA0/jjUA/fatSEwrEgI9awjd5QMB8ib1+aThVWiU
         LwXA==
X-Gm-Message-State: ABuFfoinigiW/a/FmIFOyzHWF0lQWiTBbgFN6BC73aP2IJlSCAl4EGKK
        cR+xG6glpJWVCzuY1tEadzt1lAK2jbc=
X-Google-Smtp-Source: ACcGV62s58taBr9cIL34MMccttgaj3mfB9osFpyh82PCgMeAgvfhAoWf1qpiFOm4laWbLR8rSax/KQ==
X-Received: by 2002:a50:8142:: with SMTP id 60-v6mr2447051edc.204.1538573525123;
        Wed, 03 Oct 2018 06:32:05 -0700 (PDT)
Received: from aurora.jms.id.au ([213.244.178.17])
        by smtp.gmail.com with ESMTPSA id b26-v6sm482190edw.0.2018.10.03.06.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 06:32:04 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Wed, 03 Oct 2018 15:32:02 +0200
From:   Joel Stanley <joel@jms.id.au>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Christian Svensson <christian@cmd.nu>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH 0/2] rtc: Add ASPEED RTC
Date:   Wed,  3 Oct 2018 15:31:53 +0200
Message-Id: <20181003133155.27494-1-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

This adds support for the ASPEED RTC hardware.

Joel Stanley (2):
  rtc: Add ASPEED RTC driver
  dt-bindings: rtc: Add ASPEED description

 .../devicetree/bindings/rtc/rtc-aspeed.txt    |  18 +++
 drivers/rtc/Kconfig                           |  10 ++
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-aspeed.c                      | 142 ++++++++++++++++++
 4 files changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
 create mode 100644 drivers/rtc/rtc-aspeed.c

-- 
2.17.1

