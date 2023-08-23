Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEAAEE49B2
	for <linux-rtc@archiver.kernel.org>; Wed, 23 Aug 2023 10:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjHWKID (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 23 Aug 2023 06:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjHWKHo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 23 Aug 2023 06:07:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCB146BF;
        Wed, 23 Aug 2023 02:03:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCF2965957;
        Wed, 23 Aug 2023 09:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED780C433C7;
        Wed, 23 Aug 2023 09:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692781412;
        bh=cBA8LS1Y1PWRmdPmwFWha1Slu8mL5WLDumH/lb3Wq00=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=p7ERIvaGwsPAgIB7Ug9zMNgrNdzS2de6l6WnOo4Uc8hogma7QNcpFDbKvxfQeg9Hg
         Xriz5lqt+MO8nbtsIDOkoXzTuGTO1mecOZCFQ+cZXfW6vwIoCVp4mEv7g0dXqAgNz0
         yNZFR9JXpWYo2TE6y6NLsLV5X0gkAKhQm8FqfGObbu4H6bFtMZ9QMdh0fN5DEltv/s
         olHRGlFG+NMEC1MGOCcmz04ftmcrFUBdUtvG/ZUc4prq/1VBbN6LYM6k+k3kYhMCUK
         KqfDt1sSg4byhG/Zh2VJLmsVXGVlIXoSvU6xmULNZYQWUtCWHgmJ5YQbISG7xbtU3W
         wcctWwvm7+L7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id C5A0CEE49B2;
        Wed, 23 Aug 2023 09:03:31 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Subject: [PATCH 0/2] device tree support for ST M48T86
Date:   Wed, 23 Aug 2023 12:03:13 +0300
Message-Id: <20230823-m48t86_device_tree-v1-0-240023b435ac@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFHL5WQC/x2N0QqDMBAEf0XuuQEbRWN/pRQ547beg2m5C6Ug/
 nujj8PssBsZVGB0qzZSfMXknQpcLxXFhdMLTubC5Gvf1ME3bm1DDt04l23EmBVw3Hsw+6Hth0A
 lnNjgJuUUlyNd2TL0EB/FU37n2/2x73+1k/ArfQAAAA==
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692781413; l=702;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=cBA8LS1Y1PWRmdPmwFWha1Slu8mL5WLDumH/lb3Wq00=; =?utf-8?q?b=3DLXAbPcv1J0we?=
 =?utf-8?q?kD7/fEVbVWnPffGhP0mOmiNjuWFhlj2AFOPjtkZNN/bX43+mISssLNFXFj0z4Ou7?=
 goLNQ4sQCyGjIKQFMnYzGxq5JuHMbCqGiM5FgElvV56j7TNIPedg
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Add device tree support for ST M48T86.

The reason it can't go to trivial-rtc.yaml, is that it has 2 registers
instead of a single one. The registers are 1 byte wide.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Nikita Shubin (2):
      dt-bindings: rtc: Add ST M48T86
      rtc: m48t86: add DT support for m48t86

 .../devicetree/bindings/rtc/st,m48t86.yaml         | 38 ++++++++++++++++++++++
 drivers/rtc/rtc-m48t86.c                           |  8 +++++
 2 files changed, 46 insertions(+)
---
base-commit: 89bf6209cad66214d3774dac86b6bbf2aec6a30d
change-id: 20230823-m48t86_device_tree-a72eaa294798

Best regards,
-- 
Nikita Shubin <nikita.shubin@maquefel.me>

