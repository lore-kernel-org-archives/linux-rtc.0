Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524BB483824;
	Thu, 24 Sep 2026 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286696; cv=none; b=pmUGOCadkvjYrmcVYR7TGb80SkgDV8SDB8upr/1PRlFVDDW8RbBfUFrMnddqG5ao+VQs7l8vsl/lW8su1mhEuMP4cKev7YxYgMqvL8HZH79QNSErNB1WleIxSMOp9EynhGVp5+CuA6Z0VTHLCNqWhNMZd+xJhn2/joixRnq1xFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286696; c=relaxed/simple;
	bh=zOHpbi8+Kegt6wmaPBM3kbO+SSsXgtPkexb1PU3nz2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZmC64IIIi0Y+6uUqc6shECsI0GaIsy2uiyjnDBAI06Afav3kzhQLBMrn1NXKQrQIkxv5TfAb5M/ibTxTaDO3fnEDkfeyKBkPBEvy9PcZtcs1NQ9VM9IuC0FubcCjJ0qCPyXkKV/XRBm12KcRAroJcWRVmG2QjxGcomUeMegWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5MdEJ3c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5MdEJ3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A871F000FF;
	Thu, 24 Sep 2026 21:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790286695;
	bh=CBXciCp72PGbiXDsjM5x2kd0yc/32rgcTgrflB68NAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q5MdEJ3cTUyuwTMa9HF8gJEafKCXeUVSFJjRKmNiI6kOs3FmwGHmqVL4zU++2uNi2
	 vJvp+4Kn/YMx6bWTjvXBw20KIptuonSkUH1yVMDPncx+f3zvcoqr8vP/Ix5D8Y+NqB
	 t3aoZ95et+AJ7cXSqX0gMFl78dy1BoFRHrFX3GLiesXmVAlummDrkc6/GVh8ShZxaK
	 BajJmMf9hEPEWrIvE63zx5vddhfXmA+hcXU39K19/FZzN/USEIWgsSG2zpOkDBDqpe
	 lq6BfciG1x6Y/6bUFRFxC7sbG8OHClSlJj1/wqFQY/P/yQEzTdd63Ghb2cnqzCChue
	 C4Vh6sUOuGivg==
Date: Thu, 24 Sep 2026 16:51:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Magnus Damm <magnus.damm@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-rtc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Lad Prabhakar <prabhakar.csengg@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: rtc: rzn1: add R-Car Gen5 support
Message-ID: <179028669164.1881581.11615657721277413574.robh@kernel.org>
References: <20260916102520.24288-1-wsa+renesas@sang-engineering.com>
 <20260916102520.24288-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916102520.24288-4-wsa+renesas@sang-engineering.com>


On Wed, 16 Sep 2026 12:25:18 +0200, Wolfram Sang wrote:
> In general, the RTC on R-Car Gen5 is identical to RZ/T2H. X5H is an
> exception, though, because interrupts are not wired. X5H2 will have them
> wired again.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../bindings/rtc/renesas,rzn1-rtc.yaml        | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

