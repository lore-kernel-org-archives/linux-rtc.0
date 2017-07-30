Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60172 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdG3Okg (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 30 Jul 2017 10:40:36 -0400
Date: Sun, 30 Jul 2017 16:40:34 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        linux-kernel@vger.kernel.org, maxime.ripard@free-electrons.com,
        wens@csie.org, robh@kernel.org
Subject: Re: [PATCH 1/3] rtc: sun6i: Remove double init of spinlock in
 sun6i_rtc_clk_init()
Message-ID: <20170730144034.keptgit33lrpzwn5@piout.net>
References: <1499857190-30849-1-git-send-email-alexey.klimov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499857190-30849-1-git-send-email-alexey.klimov@arm.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 12/07/2017 at 11:59:48 +0100, Alexey Klimov wrote:
> Fixes: 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator")
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@arm.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, after adding a proper commit message.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
