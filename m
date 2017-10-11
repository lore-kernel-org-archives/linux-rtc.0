Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:45870 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdJKVlw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 11 Oct 2017 17:41:52 -0400
Received: by mail-pf0-f174.google.com with SMTP id d28so2163694pfe.2
        for <linux-rtc@vger.kernel.org>; Wed, 11 Oct 2017 14:41:52 -0700 (PDT)
Subject: Re: [PATCH V2] imx: mx7dsabresd: include BLK for MMC/eMMC support of
 driver model
To: linux-rtc@vger.kernel.org
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, otavio.salvador@ossystems.com.br,
        peng.fan@nxp.com
References: <1507753798-20666-1-git-send-email-eric@nelint.com>
 <1507757654-22114-1-git-send-email-eric@nelint.com>
From: Eric Nelson <eric@nelint.com>
Message-ID: <c52f889f-6958-026d-c530-4a815dcd9f28@nelint.com>
Date: Wed, 11 Oct 2017 14:41:49 -0700
MIME-Version: 1.0
In-Reply-To: <1507757654-22114-1-git-send-email-eric@nelint.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Please disregard.

I chose the wrong entry in my command-line history and
sent this to the wrong list.

On 10/11/2017 02:34 PM, Eric Nelson wrote:
> Commit 6fbbcfd introduced device-tree support for MMC devices on
> the mx7sabresd boards and didn't include BLK, which requires BLK.
> 
> Commit 8ae5bb3 did the same for secure boot.
> 
> Fix both by allowing blk-uclass (BLK) support.
> 
> Tested-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Eric Nelson <eric@nelint.com>
> ---
> V2 includes the updated to mx7dsabresd_secure_defconfig
>   configs/mx7dsabresd_defconfig        | 1 -
>   configs/mx7dsabresd_secure_defconfig | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/configs/mx7dsabresd_defconfig b/configs/mx7dsabresd_defconfig
> index 795c4f2..144fb50 100644
> --- a/configs/mx7dsabresd_defconfig
> +++ b/configs/mx7dsabresd_defconfig
> @@ -38,7 +38,6 @@ CONFIG_CMD_EXT4=y
>   CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_CMD_FAT=y
>   CONFIG_OF_CONTROL=y
> -# CONFIG_BLK is not set
>   CONFIG_DFU_MMC=y
>   CONFIG_DFU_RAM=y
>   CONFIG_DM_GPIO=y
> diff --git a/configs/mx7dsabresd_secure_defconfig b/configs/mx7dsabresd_secure_defconfig
> index bd68831..d1af138 100644
> --- a/configs/mx7dsabresd_secure_defconfig
> +++ b/configs/mx7dsabresd_secure_defconfig
> @@ -40,7 +40,6 @@ CONFIG_CMD_EXT4=y
>   CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_CMD_FAT=y
>   CONFIG_OF_CONTROL=y
> -# CONFIG_BLK is not set
>   CONFIG_DFU_MMC=y
>   CONFIG_DFU_RAM=y
>   CONFIG_DM_GPIO=y
> 
