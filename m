Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60020 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754128AbdG3ObB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 30 Jul 2017 10:31:01 -0400
Date: Sun, 30 Jul 2017 16:30:59 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-rtc@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] rtc: ds1307: remove legacy check for
 "isil,irq2-can-wakeup-machine" property
Message-ID: <20170730143059.bdopnnvajlj6gw6u@piout.net>
References: <ff4ea92b-4af3-1a59-2ea3-056a43125c20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ff4ea92b-4af3-1a59-2ea3-056a43125c20@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 06/07/2017 at 22:40:03 +0200, Heiner Kallweit wrote:
> Commit 8b44f5be20fd ("ARM: dts: armada: replace isil,irq2-can-wakeup-machine with wakeup-source property")
> removed the last usage of "isil,irq2-can-wakeup-machine" almost
> two years ago. So I think we can get rid of supporting this
> legacy binding.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  Documentation/devicetree/bindings/power/wakeup-source.txt | 9 ++++-----
>  Documentation/devicetree/bindings/rtc/isil,isl12057.txt   | 1 -
>  drivers/rtc/rtc-ds1307.c                                  | 8 +-------
>  3 files changed, 5 insertions(+), 13 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
