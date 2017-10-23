Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55429 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932245AbdJWPqA (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 23 Oct 2017 11:46:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id u138so10736717wmu.4
        for <linux-rtc@vger.kernel.org>; Mon, 23 Oct 2017 08:45:59 -0700 (PDT)
Date: Mon, 23 Oct 2017 16:45:40 +0100
From: Lee Jones <lee.jones@linaro.org>
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: a.zummo@towertech.it, x86@kernel.org, wim@iguana.be,
        mingo@redhat.com, alexandre.belloni@free-electrons.com,
        qipeng.zha@intel.com, hpa@zytor.com, dvhart@infradead.org,
        tglx@linutronix.de, andy@infradead.org,
        souvik.k.chakravarty@intel.com, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com
Subject: Re: [RFC v6 8/9] platform/x86: intel_pmc_ipc: Use generic Intel IPC
 device calls
Message-ID: <20171023154540.tdl7u4ntmeljybhx@dell>
References: <cover.1508368279.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <491e7ea183ada1e50ac4ece6ca3f73ccda9cd42e.1508368279.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <491e7ea183ada1e50ac4ece6ca3f73ccda9cd42e.1508368279.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, 18 Oct 2017, sathyanarayanan.kuppuswamy@linux.intel.com wrote:

> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Removed redundant IPC helper functions and refactored the driver to use
> generic IPC device driver APIs. Also, cleaned up the driver to minimize
> the usage of global variable ipcdev by propogating the struct
> intel_pmc_ipc_dev pointer or by getting it from device private data.
> 
> This patch also cleans-up PMC IPC user drivers(intel_telemetry_pltdrv.c,
> intel_soc_pmic_bxtwc.c) to use APIs provided by generic IPC driver.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_pmc_ipc.h          |  31 +-
>  drivers/mfd/intel_soc_pmic_bxtwc.c            |  37 ++-
>  drivers/platform/x86/intel_pmc_ipc.c          | 393 ++++++++++----------------
>  drivers/platform/x86/intel_telemetry_pltdrv.c | 128 ++++-----

>  include/linux/mfd/intel_soc_pmic.h            |   2 +

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
