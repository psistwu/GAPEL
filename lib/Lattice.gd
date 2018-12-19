#############################################################################
##
#W  Lattice.gd		GAP Package `EquiDeg'			    Haopin Wu
##
#Y  Copyright (C) 2017-2018, Haopin Wu
#Y  Department of Mathematics, National Tsing Hua University, Taiwan
##
##  This file contains declarations for procedures related to lattice.
##
##  Todo:
##    1. Make <IsPSortedList> a property instead of a operation.
##       In exchange, add operation <IsPSortedListBy>.
##    2. Add property <IsPoset>, which is synonym for
##       <IsPSortedList and IsDuplicateFreeList>.
##

##  Part 1: Poset

#############################################################################
##
#O  IsPSortedList( <list>[, <func>] )
##
##  <#GAPDoc Label="IsPSortedList">
##  <ManSection>
##  <Oper Name="IsPSortedList" Arg="list[, func]"/>
##  <Description>
##    checks whether <A>list</A> is a sorted
##    with respect to partial order <A>func</A>,
##    or <C>&bslash;&lt;</C> if <A>func</A> is not given.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
  DeclareOperation( "IsPSortedList", [ IsHomogeneousList, IsFunction ] );

#############################################################################
##
#O  PSort( <list>[, <func>] )
##
##  <#GAPDoc Label="PSort">
##  <ManSection>
##  <Oper Name="PSort" Arg="list[, func]"/>
##  <Description>
##    sorts <A>list</A> with respect to partial order <A>func</A>,
##    or <C>&bslash;&lt;</C> if <A>func</A> is not given.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
  DeclareOperation( "PSort",
      [ IsHomogeneousList and IsMutable, IsFunction ] );

#############################################################################
##
#O  PSortedList( <list>[, <func>] )
##
##  <#GAPDoc Label="PSortedList">
##  <ManSection>
##  <Oper Name="PSortedList" Arg="list[, func]"/>
##  <Description>
##    returns a shallow copy of <A>list</A>
##    which is sorted
##    with respect to partial order <A>func</A>,
##    or <C>&bslash;&lt;</C> if <A>func</A> is not given.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
  DeclareOperation( "PSortedList", [ IsHomogeneousList, IsFunction ] );


##  Part 2: Lattice

#############################################################################
##
#R  IsLatticeRep
##
##  <#GAPDoc Label="IsLatticeRep">
##  <ManSection>
##  <Filt Name="IsLatticeRep" Type="representation"/>
##  <Description>
##    This is a lattice representation of a poset,
##    which allows visualizing its hierarchy structure.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
  DeclareRepresentation( "IsLatticeRep",
      IsComponentObjectRep and IsAttributeStoringRep, [ ] );

#############################################################################
##
#U  NewLattice( <filter>, <r> )
##
##  <#GAPDoc Label="NewLattice">
##  <ManSection>
##  <Constr Name="NewLattice" Arg="IsLatticeRep, r"/>
##  <Description>
##    generates a poset with lattice representation.
##    Record <A>r</A> must contain all necessary information for
##    the lattice, including:
##    <List>
##    <Mark><C>poset</C></Mark>
##    <Item>
##      A sorted poset.
##    </Item>
##    <Mark><C>node_labels</C></Mark>
##    <Item>
##      A list of node labels for elements in the poset.
##      The order of the list corresponds to that of <C>slist</C>.
##    </Item>
##    <Mark><C>node_shapes</C></Mark>
##    <Item>
##      A list of node shapes for elements in the poset.
##      The order of the list corresponds to that of <C>slist</C>.
##    </Item>
##    <Mark><C>rank_type</C></Mark>
##    <Item>
##      A string indicating the type of the rank of the lattice.
##      For example, for a CCS lattice of a group,
##      a type of rank can be order of subgroup;
##      for a orbit type lattice of a group representation,
##      a type of rank can be dimension of fixed space.
##    </Item>
##    <Mark><C>ranks</C></Mark>
##    <Item>
##      A list of rank for elements in the poset.
##      The order of the list corresponds to that of <C>slist</C>.
##    </Item>
##    <Mark><C>is_rank_reversed</C></Mark>
##    <Item>
##      A booling value which indicates how the lattice will be
##      organized: either putting low rank elements above
##      (if the value is <C>false</C>) or
##      putting high rank elements above
##      (if the value is <C>true</C>).
##    </Item>
##    </List>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
  DeclareConstructor(
    "NewLattice",
    [ IsLatticeRep,
      IsRecord ]
  );

#############################################################################
##
#A  MaximalSubElementsLattice( <lat> )
##
##  <#GAPDoc Label="MaximalSubElementsLattice">
##  <ManSection>
##  <Attr Name="MaximalSubElementsLattice" Arg="lat"/>
##  <Description>
##    For a lattice <A>lat</A>, this attribute contains the
##    list of maximal sub-elements, which is a list of indices
##    corresponding to <C>Enumerator( <A>lat</A> )</C>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
  DeclareAttribute( "MaximalSubElementsLattice",
      IsCollection and IsLatticeRep );

#############################################################################
##
#A  MinimalSupElementsLattice( <lat> )	(not yet implemented)
##
##  <#GAPDoc Label="MinimalSupElementsLattice">
##  <ManSection>
##  <Attr Name="MinimalSupElementsLattice" Arg="lat"/>
##  <Description>
##    For a lattice <A>lat</A>, this attribute contains the
##    list of minimal sup-elements, which is a list of indices
##    corresponding to <C>Enumerator( <A>lat</A> )</C>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
# DeclareAttribute( "MinimalSupElementsLattice",
#     IsCollection and IsLatticeRep );

#############################################################################
##
#O  DotFileLattice( <lat>, <filename> )
##
##  <#GAPDoc Label="DotFileLattice">
##  <ManSection>
##  <Oper Name="DotFileLattice" Arg="lat, filename"/>
##  <Description>
##    This function produces graphical representation of the CCSs
##    lattice <A>lat</A> in file <A>filename</A>.
##    The output is in <C>.dot</C> format.
##    For details and information about this format,
##    please see <URL>http://www.graphviz.org</URL>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
  DeclareOperation( "DotFileLattice", [ IsLatticeRep, IsString ] );


#############################################################################
##
#E  Lattice.gd . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here
