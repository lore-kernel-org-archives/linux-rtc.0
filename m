Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844EE38838F;
	Fri,  4 Sep 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532498; cv=none; b=MM5Ht0kgIL23+Hq2HQ7KWDY/dqUy5e6lr41eJFDDUBWpVsD0Kd+QbE5wYfcBhrgozIVSnFukETsovzGeznUQDba2/ivyd/OWSq8O1nr+SyWlS0DxDMuuoomgS48/v5t2q7FkB2YyDaVxxEl3zYyPpV3MXNJ3m8MZJaZUBJIfzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532498; c=relaxed/simple;
	bh=dEgzzZXipmG5VqSZx0OqWcK6W9itVnjwIUImu+wggoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRbQA14IeUzD+5xbj6LvxO/XxBdnjfIMubgnfI+mmnevlPgzAFYYDmU6SwK56ClRnpxWM2Wj7xvkLbX+Q6GbuSQ6o7Y/MwktfstdbDLu1f6ik8y1dTkyfs4sio0V0/1yAvtpcspwAuA6e71yatlcM8F50BXAVFZLenQ/qfvtxNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTGyzHFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTGyzHFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D82D1F00A3D;
	Fri,  4 Sep 2026 14:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532497;
	bh=zgrtOl3mE8Qj/O9YatbGi4RecyEpccJgIAdlfR3s3LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KTGyzHFX/S1+YCsE4h3rwdBFupDURXCGrQTWQsvPocaif1ILK0Q/DbOKCHPQtY2UY
	 D7X7kMWp/LfjwZ1cgXxOSquPJTTe3kyv8f9AWdmwQT6KRrqP0MJBEVMwL6ijCXlfHK
	 gIsSK60ggDUMCKWT3fBP9Y3PJgrq4ykTNSCTNIBhNyBLDzf6PPzkcSEVO0xPeioBT5
	 IWk+Fe7MPffKdp06tp7zbYLAtLm2GYp9StyEEdj4eA0JXFtbMV56mYx2YP/umQHN6k
	 1O9kH+0FCKaLaINvvUwrwydvykwPTQFOVyFg893DbfRxdpK982GXL7nmlyJSS26xz6
	 fPh/HWMtxs+MA==
Date: Fri, 4 Sep 2026 09:34:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Walle <mwalle@kernel.org>, linux-clk@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, devicetree@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-gpio@vger.kernel.org,
	Brian Masney <bmasney+clk@redhat.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Mark Brown <broonie@kernel.org>, mfd@lists.linux.dev,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3 03/10] dt-bindings: regulator: ROHM BD73800 regulators
Message-ID: <178853249101.538565.12975911228932485247.robh@kernel.org>
References: <cover.1788346553.git.mazziesaccount@gmail.com>
 <b6a28f05f3ebb85c8e915fbc1e523388fc50ad40.1788346553.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a28f05f3ebb85c8e915fbc1e523388fc50ad40.1788346553.git.mazziesaccount@gmail.com>


On Wed, 02 Sep 2026 14:04:15 +0300, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Add bindings for the BUCKs and LDOs on ROHM BD73800. The PMIC state
> specific voltages can be set in same fashion as with a few other ROHM
> PMICs (for example with BD718[15,28,37,47,50,79]). Same properties are
> recycled :)
> 
> The LDOs 1 and 4 can use different voltage ranges depending on the OTP
> configuration.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
> v3:
>  - No changes
> v1 => v2:
>  - Description of the state specific voltages moved to own file and
>    referenced from it (because multiple PMIC bindings used them).
> 
> The dt checker's documentation reference checker warns about the link to
> the MFD binding - which will be introduced in next commit. These commits
> have kind of a chicken and egg issue as MFD is referencing regulator
> properties introduced in this patch.
> 
> I could squash these but IMO, this is clearer for the reviewers. AFAICS,
> Both MFD and regulator subsystems tend to be busy. I could also split
> adding the MFD comment reference to own patch which would be after the
> patch adding the MFD binding, but having own patch for just adding the
> comment is a bit meh.
> 
> So, I decided to live with the broken doc-link between these two
> patches.
> ---
>  .../regulator/rohm,bd73800-regulator.yaml     | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd73800-regulator.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

