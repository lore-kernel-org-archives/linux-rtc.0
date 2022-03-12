Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79295C433F5
	for <linux-rtc@archiver.kernel.org>; Sat, 12 Mar 2022 11:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiCLLaT (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 12 Mar 2022 06:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiCLLaS (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 12 Mar 2022 06:30:18 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C10C35;
        Sat, 12 Mar 2022 03:29:09 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C3BDD240006;
        Sat, 12 Mar 2022 11:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647084548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOH08bKV9K2o0RK2gMfpuKKcHc4JTuayEfTcXVSyoKg=;
        b=SoqJe68LgVq4CRgKPCCveLY+ejVgYCvL/1qfwaBt5hGH0BPknjJBopP4JIp6xYiQQwyVla
        RvQUc2jDlwa0548Y5tV4gOvIWASgxS3dUJEYSJ6E0oTUtTlpw0qO+Xx9putEeqr3oNgpFU
        D4O+5sF3hDydCnEqR9tpM2RY9SbnsL8taQVzwxMmeEFDqFtPvgyFsGxW7EPaCfp4wgD0a+
        p44rqi3d7vJiQs2CZjhc+Ewj80jlPXDPLNxXKMPbcdaKiavaysDalf4c2VzGLNNXZ85rET
        ThhkrG9VhzsMGyIPf55tjdihiPTxn5KyIOoPtctgGk8UpirGVca1xxQPtArF7w==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Maxime Ripard <mripard@kernel.org>, linux-sunxi@lists.linux.dev,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v3 0/6] clk: sunxi-ng: Add a RTC CCU driver
Date:   Sat, 12 Mar 2022 12:29:04 +0100
Message-Id: <164708452927.194759.8728581507803680066.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203021736.13434-1-samuel@sholland.org>
References: <20220203021736.13434-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, 2 Feb 2022 20:17:30 -0600, Samuel Holland wrote:
> This patch series adds a CCU driver for the RTC in the H616, R329 and
> D1. The extra patch at the end of this series shows how it would be
> explanded to additional hardware variants.
> 
> The driver is intended to support the existing binding used for the H6,
> but also an updated binding which includes all RTC input clocks.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: rtc: sun6i: Clean up repetition
      (no commit info)
[2/6] dt-bindings: rtc: sun6i: Add H616, R329, and D1 support
      (no commit info)
[3/6] rtc: sun6i: Enable the bus clock when provided
      (no commit info)
[4/6] clk: sunxi-ng: mux: Allow muxes to have keys
      commit: b6e649834afa1fc6fd856b287e808cebe2c6fb8e
[5/6] clk: sunxi-ng: Add support for the sun6i RTC clocks
      commit: df8925adc02f1cb2c87582d688dd8991aaabf8b2
[6/6] clk: sunxi-ng: sun6i-rtc: Add support for H6
      commit: dc1d63a697304fbd246e24901e0635885856ef63

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
