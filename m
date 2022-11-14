Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C9DC4321E
	for <linux-rtc@archiver.kernel.org>; Mon, 14 Nov 2022 18:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbiKNSJX (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 14 Nov 2022 13:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbiKNSJE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 14 Nov 2022 13:09:04 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041D023E96;
        Mon, 14 Nov 2022 10:09:00 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DA2E1240006;
        Mon, 14 Nov 2022 18:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668449339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UUN6mlrt1JVfIdtNRt5aQaJHhuHU/mNoXeqpisyr50Q=;
        b=kDmADc4j0TZXhV/24fc3nz5YIr3zFsnsVNOoHs+tgaz6L7k5OA09O4qrq/lCvUANpILSl3
        QZO8YE7J15KjXdZS4rA4it9thxwpgcs41FjqEmnWgTlg6YLWqCNWsAPuEjObQM6h5OL6zn
        IqxM0EPnbqiJmD72VaRqOF79IZfE29SwhfDk8z8goKPI80jmKGkLinja0mYIsf0CdD+bhV
        HcnVF20y5LLtB330DFPvJdtlReaG1XlrssRLoe7zuQpSPJkKBuNKNDREtnAO8fv117K1q1
        rNnYJJ632gnOb6kSG7QviDTaRDKnJSt1zyy1u9769ahjYS5NEsPyg80bOyoZzg==
Date:   Mon, 14 Nov 2022 19:08:58 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-rtc@vger.kernel.org, chrome-platform@lists.linux.dev,
        Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: cros-ec: Limit RTC alarm range if needed
Message-ID: <166844930556.2096270.4852750255133310041.b4-ty@bootlin.com>
References: <20221029005400.2712577-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029005400.2712577-1-linux@roeck-us.net>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Fri, 28 Oct 2022 17:54:00 -0700, Guenter Roeck wrote:
> RTC chips on some older Chromebooks can only handle alarms less than 24
> hours in the future. Attempts to set an alarm beyond that range fails.
> The most severe impact of this limitation is that suspend requests fail
> if alarmtimer_suspend() tries to set an alarm for more than 24 hours
> in the future.
> 
> Try to set the real-time alarm to just below 24 hours if setting it to
> a larger value fails to work around the problem. While not perfect, it
> is better than just failing the call. A similar workaround is already
> implemented in the rtc-tps6586x driver.
> 
> [...]

Applied, thanks!

[1/1] rtc: cros-ec: Limit RTC alarm range if needed
      commit: a78590c82c501c53b6f30a5ee10e4261e8b377f7

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
