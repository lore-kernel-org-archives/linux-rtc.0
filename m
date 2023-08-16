Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D0AC27C53
	for <linux-rtc@archiver.kernel.org>; Wed, 16 Aug 2023 23:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244027AbjHPXC7 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 16 Aug 2023 19:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347141AbjHPXCs (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 16 Aug 2023 19:02:48 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4011C13E;
        Wed, 16 Aug 2023 16:02:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61A41FF803;
        Wed, 16 Aug 2023 23:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692226962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=meWsXWevQCtvrHRPJ8sgj2UFrD4CpP2D8gx89hSEKDM=;
        b=dYBMzIvk/ugjUgxaKLnLl17aCfLrXb46/6Oy58+MICqTA3Y2d9NPHhkvW5s+tU8zAkeItV
        W8MAIGxj36xxA1+RufFg8479HuTHtzTLY2GMw4fdr8vtr9D2jUvFHNmypX5q40JosUZXML
        svxvvzZN1RCH3xYiUUuaEoAU4BXFMMronoZZs9EzUd7p3vXomQeGcORZC9malppnDAaojd
        dCtZpuhW0gPGzxya5BKvxztSCn9jFMBjAeGSM2RrfxMkOX/Qgm1Wnd+oVDl+zA2wPFbIuK
        Hy904Iv4lEHrQwenQDyo7Z54ZezidfIDlL5Tg3GR91VYWl9TkBUNief94FIx4Q==
Date:   Thu, 17 Aug 2023 01:02:41 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Hugo Villeneuve <hugo@hugovil.com>
Cc:     Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf2127: remove unused function argument
Message-ID: <169222693690.116276.14219540728439019564.b4-ty@bootlin.com>
References: <20230801190432.3340545-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230801190432.3340545-1-hugo@hugovil.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org


On Tue, 01 Aug 2023 15:04:32 -0400, Hugo Villeneuve wrote:
> Fixes the following W=1 kernel build warning(s):
> 
> drivers/rtc/rtc-pcf2127.c: In function ‘pcf2127_probe’:
> drivers/rtc/rtc-pcf2127.c:635:32: warning: unused parameter ‘name’ [-Wunused-parameter]
>   635 |     int alarm_irq, const char *name, bool is_pcf2127)
>       |                    ~~~~~~~~~~~~^~~~
> 
> [...]

Applied, thanks!

[1/1] rtc: pcf2127: remove unused function argument
      commit: 58dffa96e62ccf30ecba718f124ce822ddc1150a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
