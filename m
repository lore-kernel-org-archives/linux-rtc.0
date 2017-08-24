Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52736 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753246AbdHXVEU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 24 Aug 2017 17:04:20 -0400
Date: Thu, 24 Aug 2017 23:04:19 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-rtc@vger.kernel.org
Subject: Re: [PATCH 0/9] rtc: ds1307: series with refactorings / improvements
Message-ID: <20170824210419.aqwpcqtftmean7nj@piout.net>
References: <aded2895-cf4b-12f0-5525-c4389ccf3650@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aded2895-cf4b-12f0-5525-c4389ccf3650@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 12/07/2017 at 07:23:31 +0200, Heiner Kallweit wrote:
> This series includes smaller refactorings and improvements.
> 
> Heiner Kallweit (9):
>   rtc: ds1307: remove member irq from struct ds1307
>   rtc: ds1307: factor out bbsqi bit to struct chip_desc
>   rtc: ds1307: improve trickle charger initialization
>   rtc: ds1307: constify struct chip_desc variables
>   rtc: ds1307: improve irq setup
>   rtc: ds1307: factor out irq_handler to struct chip_desc
>   rtc: ds1307: factor out rtc_ops to struct chip_desc
>   rtc: ds1307: factor out offset to struct chip_desc
>   rtc: ds1307: remove member nvram_offset from struct ds1307
> 
>  drivers/rtc/rtc-ds1307.c | 165 ++++++++++++++++++++++-------------------------
>  1 file changed, 76 insertions(+), 89 deletions(-)
> 

I finally reviewed and applied the series. I had to fix a few whitespace
issues though.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
