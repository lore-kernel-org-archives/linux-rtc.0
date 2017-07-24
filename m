Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:53294 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbdGXDYm (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 23 Jul 2017 23:24:42 -0400
MIME-Version: 1.0
In-Reply-To: <1499857190-30849-1-git-send-email-alexey.klimov@arm.com>
References: <1499857190-30849-1-git-send-email-alexey.klimov@arm.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 24 Jul 2017 11:24:18 +0800
Message-ID: <CAGb2v66UXM3ezjJdv0JdzdTG4qPdpcHj1DYSRJ1tBviTk-f-CA@mail.gmail.com>
Subject: Re: [PATCH 1/3] rtc: sun6i: Remove double init of spinlock in sun6i_rtc_clk_init()
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Jul 12, 2017 at 6:59 PM, Alexey Klimov <alexey.klimov@arm.com> wrote:

A bit more description would be nice. Maybe a kernel message that
prompted this fix?

> Fixes: 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator")
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@arm.com>

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
