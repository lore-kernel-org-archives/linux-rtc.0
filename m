Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:36940 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbdJLM0B (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 08:26:01 -0400
Date: Thu, 12 Oct 2017 14:25:49 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: jz4740: remove duplicate 'write' in message
Message-ID: <20171012122549.pcawuicianpoc3om@piout.net>
References: <20170910193957.25037-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170910193957.25037-1-malat@debian.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 10/09/2017 at 21:39:57 +0200, Mathieu Malaterre wrote:
> Trivial fix in error message with duplicate 'write'
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/rtc/rtc-jz4740.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
