Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35570 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbeEUTTy (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 21 May 2018 15:19:54 -0400
Subject: Re: [PATCH 1/2] rtc: brcmstb-waketimer: switch to rtc_register_device
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
References: <20180520202730.28172-1-alexandre.belloni@bootlin.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2ceb0348-b030-d584-2a20-0bc678a83b14@gmail.com>
Date: Mon, 21 May 2018 12:19:43 -0700
MIME-Version: 1.0
In-Reply-To: <20180520202730.28172-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 05/20/2018 01:27 PM, Alexandre Belloni wrote:
> Switch to devm_rtc_allocate_device/rtc_register_device.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
